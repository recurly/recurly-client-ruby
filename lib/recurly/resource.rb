require 'date'
require 'erb'

module Recurly
  # The base class for all Recurly resources (e.g. {Account}, {Subscription},
  # {Transaction}).
  #
  # Resources behave much like
  # {ActiveModel}[http://rubydoc.info/gems/activemodel] classes, especially
  # like {ActiveRecord}[http://rubydoc.info/gems/activerecord].
  #
  # == Life Cycle
  #
  # To take you through the typical life cycle of a resource, we'll use
  # {Recurly::Account} as an example.
  #
  # === Creating a Record
  #
  # You can instantiate a record before attempting to save it.
  #
  #   account = Recurly::Account.new :first_name => 'Walter'
  #
  # Once instantiated, you can assign and reassign any attribute.
  #
  #   account.first_name = 'Walt'
  #   account.last_name = 'White'
  #
  # When you're ready to save, do so.
  #
  #   account.save # => false
  #
  # If save returns +false+, validation likely failed. You can check the record
  # for errors.
  #
  #   account.errors # => {"account_code"=>["can't be blank"]}
  #
  # Once the errors are fixed, you can try again.
  #
  #   account.account_code = 'heisenberg'
  #   account.save # => true
  #
  # The object will be updated with any information provided by the server
  # (including any UUIDs set).
  #
  #   account.created_at # => 2011-04-30 07:13:35 -0700
  #
  # You can also create accounts in one fell swoop.
  #
  #   Recurly::Account.create(
  #     :first_name   => 'Jesse'
  #     :last_name    => 'Pinkman'
  #     :account_code => 'capn_cook'
  #   )
  #   # => #<Recurly::Account account_code: "capn_cook" ...>
  #
  # You can use alternative "bang" methods for exception control. If the record
  # fails to save, a Recurly::Resource::Invalid exception will be raised.
  #
  #   begin
  #     account = Recurly::Account.new :first_name => 'Junior'
  #     account.save!
  #   rescue Recurly::Resource::Invalid
  #     p account.errors
  #   end
  #
  # You can access the invalid record from the exception itself (if, for
  # example, you use the <tt>create!</tt> method).
  #
  #   begin
  #     Recurly::Account.create! :first_name => 'Skylar', :last_name => 'White'
  #   rescue Recurly::Resource::Invalid => e
  #     p e.record.errors
  #   end
  #
  # === Fetching a Record
  #
  # Records are fetched by their unique identifiers.
  #
  #   account = Recurly::Account.find 'better_call_saul'
  #   # => #<Recurly::Account account_code: "better_call_saul" ...>
  #
  # If the record doesn't exist, a Recurly::Resource::NotFound exception will
  # be raised.
  #
  # === Updating a Record
  #
  # Once fetched, a record can be updated with a hash of attributes.
  #
  #   account.update_attributes :first_name => 'Saul', :last_name => 'Goodman'
  #   # => true
  #
  # (A bang method, update_attributes!, will raise Recurly::Resource::Invalid.)
  #
  # You can also update a record by setting attributes and calling save.
  #
  #   account.last_name = 'McGill'
  #   account.save # Alternatively, call save!
  #
  # === Deleting a Record
  #
  # To delete (deactivate, close, etc.) a fetched record, merely call destroy
  # on it.
  #
  #   account.destroy # => true
  #
  # === Fetching a List of Records
  #
  # If you want to iterate over a list of accounts, you can use a Pager.
  #
  #   pager = Account.paginate :per_page => 50
  #
  # If you want to iterate over _every_ record, a convenience method will
  # automatically paginate:
  #
  #   Account.find_each { |account| p account }
  class Resource
    require 'recurly/resource/errors'
    require 'recurly/resource/pager'
    require 'recurly/resource/association'

    # Raised when a record cannot be found.
    #
    # @example
    #   begin
    #     Recurly::Account.find 'tortuga'
    #   rescue Recurly::Resource::NotFound => e
    #     e.message # => "Can't find Account with account_code = tortuga"
    #   end
    class NotFound < API::NotFound
      def initialize message
        set_message message
      end
    end

    # Raised when a record is invalid.
    #
    # @example
    #   begin
    #     Recurly::Account.create! :first_name => "Flynn"
    #   rescue Recurly::Resource::Invalid => e
    #     e.record.errors # => errors: {"account_code"=>["can't be blank"]}>
    #   end
    class Invalid < API::UnprocessableEntity
      # @return [Resource, nil] The invalid record.
      attr_reader :record

      def initialize record_or_message
        set_message case record_or_message
        when Resource
          @record = record_or_message
          record_or_message.errors.map { |k, v| "#{k} #{v * ', '}" }.join '; '
        else
          record_or_message
        end
      end
    end

    class << self
      # @return [String] The demodulized name of the resource class.
      # @example
      #   Recurly::Account.name # => "Account"
      def resource_name
        Helper.demodulize name
      end

      # @return [String] The underscored, pluralized name of the resource
      #   class.
      # @example
      #   Recurly::Account.collection_name # => "accounts"
      def collection_name
        Helper.pluralize Helper.underscore(resource_name)
      end
      alias collection_path collection_name

      # @return [String] The underscored name of the resource class.
      # @example
      #   Recurly::Account.member_name # => "account"
      def member_name
        Helper.underscore resource_name
      end

      # @return [String] The relative path to a resource's identifier from the
      #   API's base URI.
      # @param uuid [String, nil]
      # @example
      #   Recurly::Account.member_path "code" # => "accounts/code"
      #   Recurly::Account.member_path nil    # => "accounts"
      def member_path uuid
        uuid = ERB::Util.url_encode(uuid) if uuid
        [collection_path, uuid].compact.join '/'
      end

      # @return [Array] Per attribute, defines readers, writers, boolean and
      #   change-tracking methods.
      # @param attribute_names [Array] An array of attribute names.
      # @example
      #   class Account < Resource
      #     define_attribute_methods [:name]
      #   end
      #
      #   a = Account.new
      #   a.name?            # => false
      #   a.name             # => nil
      #   a.name = "Stephen"
      #   a.name?            # => true
      #   a.name             # => "Stephen"
      #   a.name_changed?    # => true
      #   a.name_was         # => nil
      #   a.name_change      # => [nil, "Stephen"]
      def define_attribute_methods attribute_names
        @attribute_names = attribute_names.map! { |m| m.to_s }.sort!.freeze
        remove_const :AttributeMethods if constants.include? :AttributeMethods
        include const_set :AttributeMethods, Module.new {
          attribute_names.each do |name|
            define_method(name) { self[name] }                       # Get.
            define_method("#{name}=") { |value| self[name] = value } # Set.
            define_method("#{name}?") { !!self[name] }               # Present.
            define_method("#{name}_change") { changes[name] }        # Dirt...
            define_method("#{name}_changed?") { changed_attributes.key? name }
            define_method("#{name}_was") { changed_attributes[name] }
            define_method("#{name}_previously_changed?") {
              previous_changes.key? name
            }
            define_method("#{name}_previously_was") {
              previous_changes[name].first if previous_changes.key? name
            }
          end
        }
      end

      # @return [Array, nil] The list of attribute names defined for the
      #   resource class.
      attr_reader :attribute_names

      # @return [Pager] A pager with an iterable collection of records
      # @param options [Hash] A hash of pagination options
      # @option options [Integer] :per_page The number of records returned per
      #   page
      # @option options [DateTime, Time, Integer] :cursor A timestamp that the
      #   pager will skim back to and return records created before it
      # @option options [String] :etag When set, will raise
      #   {Recurly::API::NotModified} if the pager's loaded page content has
      #   not changed
      # @example Fetch 50 records and iterate over them
      #   Recurly::Account.paginate(:per_page => 50).each { |a| p a }
      # @example Fetch records before January 1, 2011
      #   Recurly::Account.paginate(:cursor => Time.new(2011, 1, 1))
      def paginate options = {}
        Pager.new self, options
      end
      alias scoped paginate
      alias where  paginate

      def all options = {}
        paginate(options).to_a
      end

      # @return [Hash] Defined scopes per resource.
      def scopes
        @scopes ||= Recurly::Helper.hash_with_indifferent_read_access
      end

      # @return [Module] Module of scopes methods.
      def scopes_helper
        @scopes_helper ||= Module.new.tap { |helper| extend helper }
      end

      # Defines a new resource scope.
      #
      # @return [Proc]
      # @param [Symbol] name the scope name
      # @param [Hash] params the scope params
      def scope name, params = {}
        scopes[name = name.to_s] = params
        scopes_helper.send(:define_method, name) { paginate scopes[name] }
      end

      # Iterates through every record by automatically paging.
      #
      # @return [nil]
      # @param [Integer] per_page The number of records returned per request.
      # @yield [record]
      # @see Pager#find_each
      # @example
      #   Recurly::Account.find_each { |a| p a }
      def find_each per_page = 50, &block
        paginate(:per_page => per_page).find_each(&block)
      end

      # @return [Integer] The total record count of the resource in question.
      # @see Pager#count
      # @example
      #   Recurly::Account.count # => 42
      def count
        paginate.count
      end

      # @api internal
      # @return [Resource, nil]
      def first
        paginate(:per_page => 1).first
      end

      # @return [Resource] A record matching the designated unique identifier.
      # @param [String] uuid The unique identifier of the resource to be
      #   retrieved.
      # @param [Hash] options A hash of options.
      # @option options [String] :etag When set, will raise {API::NotModified}
      #   if the record content has not changed.
      # @raise [Error] If the resource has no identifier (and thus cannot be
      #   retrieved).
      # @raise [NotFound] If no resource can be found for the supplied
      #   identifier (or the supplied identifier is +nil+).
      # @raise [API::NotModified] If the <tt>:etag</tt> option is set and
      #   matches the server's.
      # @example
      #   Recurly::Account.find "heisenberg"
      #   # => #<Recurly::Account account_code: "heisenberg", ...>
      #   Use the following identifiers for these types of objects:
      #     for accounts use account_code
      #     for plans use plan_code
      #     for invoices use invoice_number
      #     for subscriptions use uuid
      #     for transactions use uuid
      def find uuid, options = {}
        if uuid.nil?
          # Should we raise an ArgumentError, instead?
          raise NotFound, "can't find a record with nil identifier"
        end

        uri = uuid =~ /^http/ ? uuid : member_path(uuid)
        begin
          from_response API.get(uri, {}, options)
        rescue API::NotFound => e
          raise NotFound, e.description
        end
      end

      # Instantiates and attempts to save a record.
      #
      # @return [Resource] The record.
      # @raise [Transaction::Error] A monetary transaction failed.
      # @see create!
      def create attributes = {}
        new(attributes) { |record| record.save }
      end

      # Instantiates and attempts to save a record.
      #
      # @return [Resource] The saved record.
      # @raise [Invalid] The record is invalid.
      # @raise [Transaction::Error] A monetary transaction failed.
      # @see create
      def create! attributes = {}
        new(attributes) { |record| record.save! }
      end

      # Instantiates a record from an HTTP response, setting the record's
      # response attribute in the process.
      #
      # @return [Resource]
      # @param response [Net::HTTPResponse]
      def from_response response
        case response['Content-Type']
        when %r{application/pdf}
          response.body
        else # when %r{application/xml}
          record = from_xml response.body
          record.instance_eval { @etag, @response = response['ETag'], response }
          record
        end
      end

      # Instantiates a record from an XML blob: either a String or XML element.
      #
      # Assuming the record is from an API response, the record is flagged as
      # persisted.
      #
      # @return [Resource]
      # @param xml [String, REXML::Element, Nokogiri::XML::Node]
      # @see from_response
      def from_xml xml
        xml = XML.new xml
        if self != Resource || xml.name == member_name
          record = new
        elsif Recurly.const_defined?(
          class_name = Helper.classify(xml.name), false
        )
          klass = Recurly.const_get class_name, false
          record = klass.send :new
        elsif root = xml.root and root.elements.empty?
          return XML.cast root
        else
          record = {}
        end
        klass ||= self

        xml.root.attributes.each do |name, value|
          record.instance_variable_set "@#{name}", value.to_s
        end

        xml.each_element do |el|
          if el.name == 'a'
            record.links[el.attribute('name').value] = {
              :method => el.attribute('method').to_s,
              :href => el.attribute('href').value
            }
            next
          end
          
          # Nokogiri on Jruby-1.7.19 likes to throw NullPointer exceptions
          # if you try to run certian operations like el.attribute(''). Since
          # we dont care about text nodes, let's just skip them
          next if defined?(Nokogiri::XML::Node::TEXT_NODE) && el.node_type == Nokogiri::XML::Node::TEXT_NODE 
          
          if el.children.empty? && href = el.attribute('href')
            klass_name = Helper.classify(klass.association_class_name(el.name) ||
                                         el.attribute('type') ||
                                         el.name)

            next unless Recurly.const_defined?(klass_name)

            resource_class = Recurly.const_get(klass_name, false)

            case el.name
            when *klass.associations_for_relation(:has_many)
              record[el.name] = Pager.new(
                resource_class, :uri => href.value, :parent => record
              )
            when *(klass.associations_for_relation(:has_one) + klass.associations_for_relation(:belongs_to))
              record.links[el.name] = {
                :resource_class => resource_class,
                :method => :get,
                :href => href.value
              }
            end
          else
            val = XML.cast(el)
            if 'address' == el.name && val.kind_of?(Hash)
              address = Address.new val
              address.instance_variable_set(:@changed_attributes, {})
              record[el.name] = address
            else
              record[el.name] = val
            end
          end
        end

        record.persist! if record.respond_to? :persist!
        record
      end

      # @return [Array] A list of associations for the current class.
      def associations
        @associations ||= []
      end

      # @return [Array] A list of associated resource classes with
      # the relation [:has_many, :has_one, :belongs_to] for the current class.
      def associations_for_relation(relation)
        associations.select{ |a| a.relation == relation }.map(&:resource_class)
      end

      # @return [String, nil] The actual associated resource class name
      # for the current class if the resource class does not match the
      # actual class.
      def association_class_name(resource_class)
        association = find_association(resource_class)
        association.class_name if association
      end

      # @return [Association, nil] Find association for the current class
      #                            with resource class name.
      def find_association(resource_class)
        associations.find{ |a| a.resource_class == resource_class }
      end

      def associations_helper
        @associations_helper ||= Module.new.tap { |helper| include helper }
      end

      # Establishes a has_many association.
      #
      # @return [Proc, nil]
      # @param collection_name [Symbol] Association name.
      # @param options [Hash] A hash of association options.
      # @option options [true, false] :readonly Don't define a setter.
      #                 [String] :class_name Actual associated resource class name
      #                                      if not same as collection_name.
      def has_many collection_name, options = {}
        associations << Association.new(:has_many, collection_name.to_s, options)
        associations_helper.module_eval do
          define_method collection_name do
            if self[collection_name]
              self[collection_name]
            else
              attributes[collection_name] = []
            end
          end
          if options.key?(:readonly) && options[:readonly] == false
            define_method "#{collection_name}=" do |collection|
              self[collection_name] = collection
            end
          end
        end
      end

      # Establishes a has_one association.
      #
      # @return [Proc, nil]
      # @param member_name [Symbol] Association name.
      # @param options [Hash] A hash of association options.
      # @option options [true, false] :readonly Don't define a setter.
      #                 [String] :class_name Actual associated resource class name
      #                                      if not same as member_name.
      def has_one member_name, options = {}
        associations << Association.new(:has_one, member_name.to_s, options)
        associations_helper.module_eval do
          define_method(member_name) { self[member_name] }
          if options.key?(:readonly) && options[:readonly] == false
            associated = Recurly.const_get Helper.classify(member_name), false
            define_method "#{member_name}=" do |member|
              associated_uri = "#{path}/#{member_name}"
              self[member_name] = case member
              when Hash
                associated.send :new, member.merge(:uri => associated_uri)
              when associated
                member.uri = associated_uri and member
              else
                raise ArgumentError, "expected #{associated}"
              end
            end
            define_method "build_#{member_name}" do |*args|
              attributes = args.shift || {}
              self[member_name] = associated.send(
                :new, attributes.merge(:uri => "#{path}/#{member_name}")
              ).tap { |child| child.attributes[self.class.member_name] = self }
            end
            define_method "create_#{member_name}" do |*args|
              send("build_#{member_name}", *args).tap { |child| child.save }
            end
          end
        end
      end

      # Establishes a belongs_to association.
      #
      # @return [Proc]
      # @param parent_name [Symbol] Association name.
      # @param options [Hash] A hash of association options.
      # @option options [true, false] :readonly Don't define a setter.
      #                 [String] :class_name Actual associated resource class name
      #                                      if not same as parent_name.
      def belongs_to parent_name, options = {}
        associations << Association.new(:belongs_to, parent_name.to_s, options)
        associations_helper.module_eval do
          define_method(parent_name) { self[parent_name] }
          if options.key?(:readonly) && options[:readonly] == false
            define_method "#{parent_name}=" do |parent|
              self[parent_name] = parent
            end
          end
        end
      end

      # @return [:has_many, :has_one, :belongs_to, nil] An association type.
      def reflect_on_association name
        a = find_association name.to_s
        a.relation if a
      end

      def embedded! root_index = false
        private :initialize
        private_class_method(*%w(new create create!))
        unless root_index
          private_class_method(*%w(all find_each first paginate scoped where))
        end
      end
    end

    # @return [Hash] The raw hash of record attributes.
    attr_reader :attributes

    # @return [Net::HTTPResponse, nil] The most recent response object for the
    #   record (updated during {#save} and {#destroy}).
    attr_reader :response

    # @return [String, nil] An ETag for the current record.
    attr_reader :etag

    # @return [String, nil] A writer to override the URI the record saves to.
    attr_writer :uri

    # @return [Resource] A new resource instance.
    # @param attributes [Hash] A hash of attributes.
    def initialize attributes = {}
      if instance_of? Resource
        raise Error,
          "#{self.class} is an abstract class and cannot be instantiated"
      end

      @attributes, @new_record, @destroyed, @uri, @href = {}, true, false
      self.attributes = attributes
      yield self if block_given?
    end

    # @return [self] Reloads the record from the server.
    def reload response = nil
      if response
        return if response.body.to_s.length.zero?
        fresh = self.class.from_response response
      else
        fresh = self.class.find(
          @href || to_param, :etag => (etag unless changed?)
        )
      end
      fresh and copy_from fresh
      persist! true
      self
    rescue API::NotModified
      self
    end

    # @return [Hash] Hash of changed attributes.
    # @see #changes
    def changed_attributes
      @changed_attributes ||= {}
    end

    # @return [Array] A list of changed attribute keys.
    def changed
      changed_attributes.keys
    end

    # Do any attributes have unsaved changes?
    # @return [true, false]
    def changed?
      !changed_attributes.empty?
    end

    # @return [Hash] Map of changed attributes to original value and new value.
    def changes
      changed_attributes.inject({}) { |changes, (key, original_value)|
        changes[key] = [original_value, self[key]] and changes
      }
    end

    # @return [Hash] Previously-changed attributes.
    # @see #changes
    def previous_changes
      @previous_changes ||= {}
    end

    # Is the record new (i.e., not saved on Recurly's servers)?
    #
    # @return [true, false]
    # @see #persisted?
    # @see #destroyed?
    def new_record?
      @new_record
    end

    # Has the record been destroyed? (Set +true+ after a successful destroy.)
    # @return [true, false]
    # @see #new_record?
    # @see #persisted?
    def destroyed?
      @destroyed
    end

    # Has the record persisted (i.e., saved on Recurly's servers)?
    #
    # @return [true, false]
    # @see #new_record?
    # @see #destroyed?
    def persisted?
      !(new_record? || destroyed?)
    end

    # The value of a specified attribute, lazily fetching any defined
    # association.
    #
    # @param key [Symbol, String] The name of the attribute to be fetched.
    # @example
    #   account.read_attribute :first_name # => "Ted"
    #   account[:last_name]                # => "Beneke"
    # @see #write_attribute
    def read_attribute key
      key = key.to_s
      if attributes.key? key
        value = attributes[key]
      elsif links.key?(key) && self.class.reflect_on_association(key)
        value = attributes[key] = follow_link key
      end
      value
    end
    alias [] read_attribute

    # Sets the value of a specified attribute.
    #
    # @param key [Symbol, String] The name of the attribute to be set.
    # @param value [Object] The value the attribute will be set to.
    # @example
    #   account.write_attribute :first_name, 'Gus'
    #   account[:company_name] = 'Los Pollos Hermanos'
    # @see #read_attribute
    def write_attribute key, value
      if changed_attributes.key?(key = key.to_s)
        changed_attributes.delete key if changed_attributes[key] == value
      elsif self[key] != value
        changed_attributes[key] = self[key]
      end

      if self.class.find_association key
        value = fetch_association key, value
      # FIXME: More explicit; less magic.
      elsif value && key.end_with?('_in_cents') && !respond_to?(:currency)
        value = Money.new value, self, key unless value.is_a? Money
      end

      attributes[key] = value
    end
    alias []= write_attribute

    # Apply a given hash of attributes to a record.
    #
    # @return [Hash]
    # @param attributes [Hash] A hash of attributes.
    def attributes= attributes = {}
      attributes.each_pair { |k, v|
        respond_to?(name = "#{k}=") and send(name, v) or self[k] = v
      }
    end

    # @return [Hash] The raw hash of record href links.
    def links
      @links ||= {}
    end

    # Whether a record has a link with the given name.
    #
    # @param key [Symbol, String] The name of the link to check for.
    # @example
    #   account.link? :billing_info # => true
    def link? key
      links.key?(key.to_s)
    end

    # Fetch the value of a link by following the associated href.
    #
    # @param key [Symbol, String] The name of the link to be followed.
    # @param options [Hash] A hash of API options.
    # @example
    #   account.read_link :billing_info # => <Recurly::BillingInfo>
    def follow_link key, options = {}
      if link = links[key = key.to_s]
        response = API.send link[:method], link[:href], options[:body], options
        if resource_class = link[:resource_class]
          response = resource_class.from_response response
          response.attributes[self.class.member_name] = self
        end
        response
      end
    rescue Recurly::API::NotFound
      raise unless resource_class
    end

    # Serializes the record to XML.
    #
    # @return [String] An XML string.
    # @param options [Hash] A hash of XML options.
    # @example
    #   Recurly::Account.new(:account_code => 'code').to_xml
    #   # => "<account><account_code>code</account_code></account>"
    def to_xml options = {}
      builder = options[:builder] || XML.new("<#{self.class.member_name}/>")
      xml_keys.each { |key|
        value = respond_to?(key) ? send(key) : self[key]
        node = builder.add_element key

        # Duck-typing here is problematic because of ActiveSupport's #to_xml.
        case value
        when Resource, Subscription::AddOns
          value.to_xml options.merge(:builder => node)
        when Array
          value.each { |e| node.add_element Helper.singularize(key), e }
        when Hash, Recurly::Money
          value.each_pair { |k, v| node.add_element k.to_s, v }
        else
          node.text = value
        end
      }
      builder.to_s
    end

    # Attempts to save the record, returning the success of the request.
    #
    # @return [true, false]
    # @raise [Transaction::Error] A monetary transaction failed.
    # @example
    #   account = Recurly::Account.new
    #   account.save # => false
    #   account.account_code = 'account_code'
    #   account.save # => true
    # @see #save!
    def save
      if new_record? || changed?
        clear_errors
        @response = API.send(
          persisted? ? :put : :post, path, to_xml(:delta => true)
        )
        reload response
        persist! true
      end
      true
    rescue API::UnprocessableEntity => e
      apply_errors e
      Transaction::Error.validate! e, (self if is_a? Transaction)
      false
    end

    # Attempts to save the record, returning +true+ if the record was saved and
    # raising {Invalid} otherwise.
    #
    # @return [true]
    # @raise [Invalid] The record was invalid.
    # @raise [Transaction::Error] A monetary transaction failed.
    # @example
    #   account = Recurly::Account.new
    #   account.save! # raises Recurly::Resource::Invalid
    #   account.account_code = 'account_code'
    #   account.save! # => true
    # @see #save
    def save!
      save || raise(Invalid.new(self))
    end

    # @return [true, false, nil] The validity of the record: +true+ if the
    #   record was successfully saved (or persisted and unchanged), +false+ if
    #   the record was not successfully saved, or +nil+ for a record with an
    #   unknown state (i.e.  (i.e. new records that haven't been saved and
    #   persisted records with changed attributes).
    # @example
    #   account = Recurly::Account.new
    #   account.valid? # => nil
    #   account.save   # => false
    #   account.valid? # => false
    #   account.account_code = 'account_code'
    #   account.save   # => true
    #   account.valid? # => true
    def valid?
      return true if persisted? && !changed?
      errors_empty = errors.values.flatten.empty?
      return if errors_empty && changed?
      errors_empty
    end

    # Update a record with a given hash of attributes.
    #
    # @return [true, false] The success of the update.
    # @param attributes [Hash] A hash of attributes.
    # @raise [Transaction::Error] A monetary transaction failed.
    # @example
    #   account = Account.find 'junior'
    #   account.update_attributes :account_code => 'flynn' # => true
    # @see #update_attributes!
    def update_attributes attributes = {}
      self.attributes = attributes and save
    end

    # Update a record with a given hash of attributes.
    #
    # @return [true] The update was successful.
    # @param attributes [Hash] A hash of attributes.
    # @raise [Invalid] The record was invalid.
    # @raise [Transaction::Error] A monetary transaction failed.
    # @example
    #   account = Account.find 'gale_boetticher'
    #   account.update_attributes! :account_code => nil # Raises an exception.
    # @see #update_attributes
    def update_attributes! attributes = {}
      self.attributes = attributes and save!
    end

    # @return [Hash] A hash with indifferent read access containing any
    #   validation errors where the key is the attribute name and the value is
    #   an array of error messages.
    # @example
    #   account.errors                # => {"account_code"=>["can't be blank"]}
    #   account.errors[:account_code] # => ["can't be blank"]
    def errors
      @errors ||= Errors.new { |h, k| h[k] = [] }
    end

    # Marks a record as persisted, i.e. not a new or deleted record, resetting
    # any tracked attribute changes in the process. (This is an internal method
    # and should probably not be called unless you know what you're doing.)
    #
    # @api internal
    # @return [true]
    def persist! saved = false
      @new_record, @uri = false
      if changed?
        @previous_changes = changes if saved
        changed_attributes.clear
      end
      true
    end

    # @return [String, nil] The unique resource identifier (URI) of the record
    #   (if persisted).
    # @example
    #   Recurly::Account.new(:account_code => "account_code").uri # => nil
    #   Recurly::Account.find("account_code").uri
    #   # => "https://api.recurly.com/v2/accounts/account_code"
    def uri
      @href ||= ((API.base_uri + path).to_s if persisted?)
    end

    # Attempts to destroy the record.
    #
    # @return [true, false] +true+ if successful, +false+ if unable to destroy
    # (if the record does not persist on Recurly).
    # @raise [NotFound] The record cannot be found.
    # @example
    #   account = Recurly::Account.find account_code
    #   race_condition = Recurly::Account.find account_code
    #   account.destroy        # => true
    #   account.destroy        # => false (already destroyed)
    #   race_condition.destroy # raises Recurly::Resource::NotFound
    def destroy
      return false unless persisted?
      @response = API.delete uri
      @destroyed = true
    rescue API::NotFound => e
      raise NotFound, e.description
    end

    def signable_attributes
      Hash[xml_keys.map { |key| [key, self[key]] }]
    end

    def == other
      other.is_a?(self.class) && other.to_s == to_s
    end

    def marshal_dump
      [
        @attributes.reject { |k, v| v.is_a? Proc },
        @new_record,
        @destroyed,
        @uri,
        @href,
        changed_attributes,
        previous_changes,
        response,
        etag,
        links
      ]
    end

    def marshal_load serialization
      @attributes,
        @new_record,
        @destroyed,
        @uri,
        @href,
        @changed_attributes,
        @previous_changes,
        @response,
        @etag,
        @links = serialization
    end

    # @return [String]
    def inspect attributes = self.class.attribute_names.to_a
      string = "#<#{self.class}"
      string << "##@type" if instance_variable_defined? :@type
      attributes += %w(errors) if errors.any?
      string << " %s" % attributes.map { |k|
        "#{k}: #{self.send(k).inspect}"
      }.join(', ')
      string << '>'
    end
    alias to_s inspect

    protected

    def path
      @href or @uri or if persisted?
        self.class.member_path to_param
      else
        self.class.collection_path
      end
    end

    def invalid! attribute_path, error
      if attribute_path.length == 1
        errors[attribute_path[0]] << error
      else
        child, k, v = attribute_path.shift.scan(/[^\[\]=]+/)
        if c = k ? self[child].find { |d| d[k] == v } : self[child]
          c.invalid! attribute_path, error
          e = errors[child] << 'is invalid' and e.uniq!
        end
      end
    end

    def clear_errors
      errors.clear
      self.class.associations do |association|
        next unless respond_to? "#{association}=" # Clear writable only.
        [*self[association]].each do |associated|
          associated.clear_errors if associated.respond_to? :clear_errors
        end
      end
    end

    def copy_from other
      other.instance_variables.each do |ivar|
        instance_variable_set ivar, other.instance_variable_get(ivar)
      end
    end

    def apply_errors exception
      @response = exception.response
      document = XML.new exception.response.body
      document.each_element 'error' do |el|
        attribute_path = el.attribute('field').value.split '.'
        invalid! attribute_path[1, attribute_path.length], el.text
      end
    end

    private

    def fetch_association name, value
      case value
      when Array
        value.map { |each| fetch_association Helper.singularize(name), each }
      when Hash
        Recurly.const_get(Helper.classify(name), false).send :new, value
      when Proc, Resource, Resource::Pager, nil
        value
      else
        raise "unexpected association #{name.inspect}=#{value.inspect}"
      end
    end

    def xml_keys
      changed_attributes.keys.sort
    end
  end
end
