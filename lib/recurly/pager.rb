module Recurly
  class Pager
    attr_accessor :client
    attr_reader :data, :next

    def initialize(client:, path:, options: {})
      @client = client
      @path = path
      @options = options
      @next = build_path(@path, @options)
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

    def from_json(data)
      @data = data['data'].map do |resource_data|
        JSONParser.from_json(resource_data)
      end
      @next = data['next']
      @has_more = data['has_more']
    end

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
          fetch_next!
          yielder << data
          unless has_more?
            rewind!
            break
          end
        end
      end
    end

    def fetch_next!
      response = @client.next_page(self)
      from_json(JSON.parse(response.body))
    end

    def rewind!
      @data = []
      @next = build_path(@path, @options)
    end

    def build_path(path, options)
      if options.empty?
        path
      else
        "#{path}?#{URI.encode_www_form(options)}"
      end
    end
  end
end
