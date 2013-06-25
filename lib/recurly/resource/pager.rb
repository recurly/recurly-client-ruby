module Recurly
  class Resource
    # Pages through an index resource, yielding records as it goes. It's rare
    # to instantiate one on its own: use {Resource.paginate},
    # {Resource.each}, and <tt>Resource#{has_many_association}</tt>
    # instead.
    #
    # Because pagers handle +has_many+ associations, pagers can also build and
    # create child records.
    #
    # @example Through a resource class:
    #   Recurly::Account.paginate # => #<Recurly::Resource::Pager...>
    #
    #   Recurly::Account.each { |a| p a }
    # @example Through an resource instance:
    #   account.transactions
    #   # => #<Recurly::Resource::Pager...>
    #
    #   account.transactions.new(attributes) # or #create, or #create!
    #   # => #<Recurly::Transaction ...>
    class Pager
      include Enumerable

      # @return [Resource] The resource class of the pager.
      attr_reader :resource_class

      # @return [Hash, nil] A hash of links to which the pager can page.
      attr_reader :links

      # @return [String, nil] An ETag for the current page.
      attr_reader :etag

      # A pager for paginating through resource records.
      #
      # @param resource_class [Resource] The resource to be paginated.
      # @param options [Hash] A hash of pagination options.
      # @option options [Integer] :per_page The number of records returned per
      #   page.
      # @option options [DateTime, Time, Integer] :cursor A timestamp that the
      #   pager will skim back to and return records created before it.
      # @option options [String] :etag When set, will raise {API::NotModified}
      #   if the loaded page content has not changed.
      # @option options [String] :uri The default location the pager will
      #   request.
      # @raise [API::NotModified] If the <tt>:etag</tt> option is set and
      #   matches the server's.
      def initialize resource_class, options = {}
        options[:cursor] &&= options[:cursor].to_i
        @parent = options.delete :parent
        @uri    = options.delete :uri
        @etag   = options.delete :etag
        @resource_class, @options = resource_class, options
        @collection = @count = nil
      end

      # @return [String] The URI of the paginated resource.
      def uri
        @uri ||= resource_class.collection_path
      end

      # @return [Integer] The total record count of the resource in question.
      # @see Resource.count
      def count
        @count ||= API.head(uri, @options)['X-Records'].to_i
      end

      # @return [Array,Enumerator] Iterates through the current page of records.
      # @yield [record]
      # Yields each record of the current page.
      def each_current_page
        return enum_for :each_current_page unless block_given?
        load! unless @collection
        @collection.each { |record| yield record }
      end

      # @return [Enumerator] Iterates through the current page of records.
      # @yield [record]
      # Yields each record of the collection, iterating over each page if there are multiple. 
      def each
        return enum_for :each unless block_given?
        # if links['prev'] exists, we are not on the first page; if not, we're on the first page or no page yet. 
        @collection = nil if links && links['prev']
        begin
          each_current_page { |record| yield record }
        end while self.next
        # we didn't collect the records array to return, so just return an enumerator 
        enum_for :each
      end

      # @return [Array, nil] Refreshes the pager's collection of records with
      #   the next page.
      def next
        load_from links['next'], nil if links.key? 'next'
      end

      # @return [Array, nil] Refreshes the pager's collection of records with
      #   the previous page.
      def prev
        load_from links['prev'], nil if links.key? 'prev'
      end

      # @return [Array, nil] Refreshes the pager's collection of records with
      #   the first page.
      def start
        load_from links['start'], nil if links.key? 'start'
      end

      # @return [Array, nil] Load (or reload) the pager's collection from the
      #   original, supplied options.
      def load!
        load_from uri, @options
      end
      alias reload load!

      # @return [Pager] Duplicates the pager, updating it with the options
      #   supplied. Useful for resource scopes.
      # @see #initialize
      # @example
      #   Recurly::Account.active.paginate :per_page => 20
      def paginate options = {}
        dup.instance_eval {
          @collection = @count = @etag = nil
          @options = @options.merge options
          self
        }
      end
      alias scoped paginate
      alias where  paginate

      def all options = {}
        paginate(options).to_a
      end

      # Instantiates a new record in the scope of the pager.
      #
      # @return [Resource] A new record.
      # @example
      #   account = Recurly::Account.find 'schrader'
      #   subscription = account.subscriptions.new attributes
      # @see Resource.new
      def new attributes = {}
        record = resource_class.send(:new, attributes) { |r|
          r.attributes[@parent.class.member_name] ||= @parent if @parent
          r.uri = uri
        }
        yield record if block_given?
        record
      end

      # Instantiates and saves a record in the scope of the pager.
      #
      # @return [Resource] The record.
      # @raise [Transaction::Error] A monetary transaction failed.
      # @example
      #   account = Recurly::Account.find 'schrader'
      #   subscription = account.subscriptions.create attributes
      # @see Resource.create
      def create attributes = {}
        new(attributes) { |record| record.save }
      end

      # Instantiates and saves a record in the scope of the pager.
      #
      # @return [Resource] The saved record.
      # @raise [Invalid] The record is invalid.
      # @raise [Transaction::Error] A monetary transaction failed.
      # @example
      #   account = Recurly::Account.find 'schrader'
      #   subscription = account.subscriptions.create! attributes
      # @see Resource.create!
      def create! attributes = {}
        new(attributes) { |record| record.save! }
      end

      def find uuid
        if resource_class.respond_to? :find
          raise NoMethodError,
            "#find must be called on #{resource_class} directly"
        end

        resource_class.from_response API.get("#{uri}/#{uuid}")
      end

      # @return [true, false]
      # @see Object#respond_to?
      def respond_to? method_name, include_private = false
        super || [].respond_to?(method_name, include_private)
      end

      private

      def load_from uri, params
        options = {}
        options[:head] = { 'If-None-Match' => etag } if etag
        response = API.get uri, params, options

        @etag = response['ETag']
        @count = response['X-Records'].to_i
        @links = {}
        if links = response['Link']
          links.scan(/<([^>]+)>; rel="([^"]+)"/).each do |link, rel|
            @links[rel] = link.freeze
          end
        end
        @links.freeze

        @collection = []
        document = XML.new response.body
        document.each_element(resource_class.member_name) do |el|
          record = resource_class.from_xml el
          record.attributes[@parent.class.member_name] = @parent if @parent
          @collection << record
        end
        @collection.freeze
      rescue API::NotModified
        @collection and @collection or raise
      end

      def method_missing name, *args, &block
        scope = resource_class.scopes[name] and return paginate scope

        if [].respond_to? name
          load! unless @collection
          return @collection.send name, *args, &block
        end

        super
      end
    end
  end
end
