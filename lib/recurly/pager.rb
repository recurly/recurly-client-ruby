module Recurly
  class Pager
    attr_accessor :client
    attr_reader :data, :next

    def initialize(client:, path:, options: {})
      @client = client
      @path = path
      @options = options
      rewind!
    end

    # Performs a request with the pager `limit` set to 1 and only returns the first
    # result in the response.
    def first
      # Modify the @next url to set the :limit to 1
      original_next = @next
      @next = @path
      fetch_next!(@options.merge(params: @options.fetch(:params, {}).merge({ limit: 1 })))
      # Restore the @next url to the original
      @next = original_next
      @data.first
    end

    # Makes a HEAD request to the API to determine how many total records exist.
    def count
      resource = @client.send(:head, self.next, @options)
      resource.get_response.total_records
    end

    # Enumerates each "page" from the server.
    # This method yields a given block with the array of items
    # in the page `data` and the page number the pagination is on
    # `page_num` which is 0-indexed.
    #
    # @example
    #   plans = client.list_plans()
    #   plans.each_page do |data|
    #     data.each do |plan|
    #       puts "Plan: #{plan.id}"
    #     end
    #   end
    # @example
    #   plans = client.list_plans()
    #   plans.each_page.each_with_index do |data, page_num|
    #     puts "Page Number: #{page_num}"
    #     data.each do |plan|
    #       puts "Plan: #{plan.id}"
    #     end
    #   end
    def each_page(&block)
      if block_given?
        page_enumerator.each(&block)
      else
        page_enumerator
      end
    end

    # Enumerates each item on the server. Each item is yielded to the
    # block presenting the effect of a continuous stream of items.
    # In reality, the pager is fetching blocks of data (pages) under the hood.
    # This method yields a given block with the next item to process.
    #
    # @example
    #   plans = client.list_plans()
    #   plans.each do |plan|
    #     puts "Plan: #{plan.id}"
    #   end
    # @example
    #   plans = client.list_plans()
    #   plans.each.each_with_index do |plan, idx|
    #     puts "Plan #{idx}: #{plan.id}"
    #   end
    def each(&block)
      if block_given?
        item_enumerator.each(&block)
      else
        item_enumerator
      end
    end

    def has_more?
      !!@has_more
    end

    def requires_client?
      true
    end

    private

    def item_enumerator
      Enumerator.new do |yielder|
        page_enumerator.each do |data|
          data.each do |item|
            yielder << item
          end
        end
      end
    end

    def page_enumerator
      Enumerator.new do |yielder|
        loop do
          # Pass in @options when requesting the first page (@data.empty?)
          next_options = @data.empty? ? @options : @options.merge(params: {})
          fetch_next!(next_options)
          yielder << data
          unless has_more?
            rewind!
            break
          end
        end
      end
    end

    def fetch_next!(options)
      path = extract_path(self.next)
      page = @client.send(:get, path, options)
      @data = page.data.map { |d| JSONParser.from_json(d) }
      @has_more = page.has_more
      @next = page.next
    end

    def rewind!
      @data = []
      @next = @path
    end

    # Returns just the path and parameters so we can safely reuse the connection
    def extract_path(uri_or_path)
      uri = URI(uri_or_path)
      uri.kind_of?(URI::HTTP) ? uri.request_uri : uri_or_path
    end
  end
end
