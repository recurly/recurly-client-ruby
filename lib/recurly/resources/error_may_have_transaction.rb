# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class ErrorMayHaveTransaction < Resource
      
      # @!attribute message
      #   @return [String] Message
      define_attribute :message, String
      
      # @!attribute params
      #   @return [Array[Hash]] Parameter specific errors
      define_attribute :params, Array, {:item_type=>Hash}
      
      # @!attribute transaction_error
      #   @return [TransactionError] This is only included on errors with `type=transaction`.
      define_attribute :transaction_error, :TransactionError
      
      # @!attribute type
      #   @return [String] Type
      define_attribute :type, String
      
    end
  end
end
