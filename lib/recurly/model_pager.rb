# frozen_string_literal: true

module Recurly
  # Pager extension for Recurly ORM Interface models, allowing iteration over model instances.
  class ModelPager < Pager
    include Enumerable

    def initialize(model_class:, pager:, filters: [])
      @model_class = model_class
      @filter = ModelFilter.new(filters)
      super(client: pager.client, path: pager.next, options: pager.instance_variable_get(:@options))
    end

    def each(&block)
      super do |item|
        model = @model_class.new(item)
        block.call(model) if @filter.include?(model)
      end
    end

    def each_page(&block)
      super do |page|
        transformed_page = page.each_with_object([]) do |item, result|
          model = @model_class.new(item)
          result << model if @filter.include?(model)
        end
        block.call(transformed_page) if block_given?
      end
    end
  end
end
