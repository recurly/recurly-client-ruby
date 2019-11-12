# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class InvoiceLineItems < Resource

      # @!attribute applied_credits
      #   @return [Array[LineItem]] Previous credits applied to this invoice. See their `original_line_item_id` to determine where the credit first originated.
      define_attribute :applied_credits, Array, { :item_type => :LineItem }

      # @!attribute carryforwards
      #   @return [Array[LineItem]] These charges can be ignored. They exist to consume any remaining credit balance. A new credit with the same amount will be created and placed back on the account.
      define_attribute :carryforwards, Array, { :item_type => :LineItem }

      # @!attribute charges
      #   @return [Array[LineItem]] New charges being billed for on this invoice.
      define_attribute :charges, Array, { :item_type => :LineItem }

      # @!attribute credits
      #   @return [Array[LineItem]] Refund or proration credits. This portion of the invoice can be considered a credit memo.
      define_attribute :credits, Array, { :item_type => :LineItem }
    end
  end
end
