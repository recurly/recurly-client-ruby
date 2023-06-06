module Recurly
  class BusinessEntity < Resource
    belongs_to :site

    has_many :invoices

    has_many :accounts

    define_attribute_methods %w(
      id
      code
      name
      invoice_display_address
      tax_address
      subscriber_location_countries
      default_vat_number
      default_registration_number
      created_at
      updated_at
    )

    # We do not expose PUT or POST in the v2 API.
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end