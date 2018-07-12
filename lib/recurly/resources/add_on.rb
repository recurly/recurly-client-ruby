module Recurly
  module Resources
    class AddOn < Resource

      # @!attribute accounting_code
      #   @return [String] Accounting code for invoice line items for this add-on. If no value is provided, it defaults to add-on's code.
      define_attribute :accounting_code, String

      # @!attribute code
      #   @return [String] The unique identifier for the add-on within its plan.
      define_attribute :code, String

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, {:read_only => true}

      # @!attribute currencies
      #   @return [Array[String]] Add-on pricing
      define_attribute :currencies, Array, {:item_type => String}

      # @!attribute default_quantity
      #   @return [Integer] Default quantity for the hosted pages.
      define_attribute :default_quantity, Integer

      # @!attribute [r] deleted_at
      #   @return [DateTime] Deleted at
      define_attribute :deleted_at, DateTime, {:read_only => true}

      # @!attribute display_quantity
      #   @return [Boolean] Determines if the quantity field is displayed on the hosted pages for the add-on.
      define_attribute :display_quantity, :Boolean

      # @!attribute [r] id
      #   @return [String] Add-on ID
      define_attribute :id, String, {:read_only => true}

      # @!attribute name
      #   @return [String] Describes your add-on and will appear in subscribers' invoices.
      define_attribute :name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, {:read_only => true}

      # @!attribute [r] plan_id
      #   @return [String] Plan ID
      define_attribute :plan_id, String, {:read_only => true}

      # @!attribute [r] state
      #   @return [String] Add-ons can be either active or inactive.
      define_attribute :state, String, {:read_only => true, :enum => ["active", "inactive"]}

      # @!attribute tax_code
      #   @return [String] Optional field for EU VAT merchants and Avalara AvaTax Pro merchants. If you are using Recurly's EU VAT feature, you can use values of 'unknown', 'physical', or 'digital'. If you have your own AvaTax account configured, you can use Avalara tax codes to assign custom tax rules.
      define_attribute :tax_code, String

      # @!attribute [r] updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime, {:read_only => true}
    end
  end
end
