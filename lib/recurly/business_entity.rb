module Recurly
  class BusinessEntity < Resource
    belongs_to :site
    belongs_to :default_revenue_gl_account, class_name: 'GeneralLedgerAccount'
    belongs_to :default_liability_gl_account, class_name: 'GeneralLedgerAccount'

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
      default_revenue_gl_account_id
      default_liability_gl_account_id
      created_at
      updated_at
    )

    def self.collection_path
      "business_entities"
    end

    # We do not expose PUT or POST in the v2 API.
    protected(*%w(save save!))
    private_class_method(*%w(create! create))
  end
end
