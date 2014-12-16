module Recurly
  class AddOn < Resource
    # @return [Plan]
    belongs_to :plan

    define_attribute_methods %w(
      add_on_code
      name
      accounting_code
      default_quantity
      unit_amount_in_cents
      display_quantity_on_hosted_page
      tax_code
      created_at
    )
    alias to_param add_on_code
    alias quantity default_quantity

    # Add-ons are only writeable and readable through {Plan} instances.
    embedded!
    private_class_method :find
  end
end
