# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class BillingInfo < Resource

      # @!attribute [r] account_id
      #   @return [String]
      define_attribute :account_id, String, {:read_only => true}

      # @!attribute address
      #   @return [Address]
      define_attribute :address, :Address

      # @!attribute company
      #   @return [String]
      define_attribute :company, String

      # @!attribute [r] created_at
      #   @return [DateTime] When the billing information was created.
      define_attribute :created_at, DateTime, {:read_only => true}

      # @!attribute first_name
      #   @return [String]
      define_attribute :first_name, String

      # @!attribute [r] fraud
      #   @return [Hash] Most recent fraud result.
      define_attribute :fraud, Hash, {:read_only => true}

      # @!attribute [r] id
      #   @return [String]
      define_attribute :id, String, {:read_only => true}

      # @!attribute last_name
      #   @return [String]
      define_attribute :last_name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only => true}

      # @!attribute payment_method
      #   @return [Hash]
      define_attribute :payment_method, Hash

      # @!attribute [r] updated_at
      #   @return [DateTime] When the billing information was last changed.
      define_attribute :updated_at, DateTime, {:read_only => true}

      # @!attribute [r] updated_by
      #   @return [Hash]
      define_attribute :updated_by, Hash, {:read_only => true}

      # @!attribute [r] valid
      #   @return [Boolean]
      define_attribute :valid, :Boolean, {:read_only => true}

      # @!attribute vat_number
      #   @return [String] Customer's VAT number (to avoid having the VAT applied). This is only used for automatically collected invoices.
      define_attribute :vat_number, String
    end
  end
end
