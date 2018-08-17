module Recurly
  module Resources
    class LineItemList < Resource

      # @!attribute data
      #   @return [Array[LineItem]]
      define_attribute :data, Array, {:item_type => :LineItem}

      # @!attribute has_more
      #   @return [Boolean] Indicates there are more results on subsequent pages.
      define_attribute :has_more, :Boolean

      # @!attribute next
      #   @return [String] Path to subsequent page of results.
      define_attribute :next, String

      # @!attribute object
      #   @return [String] Will always be List.
      define_attribute :object, String
    end
  end
end
