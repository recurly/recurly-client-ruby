module Recurly
  class BillingInfo < AccountBase
    self.element_name = "billing_info"

    def self.known_attributes
      [
        "first_name",
        "last_name",
        "address1",
        "address2",
        "city",
        "state",
        "zip",
        "country",
        "phone",
        "ip_address",
        "vat_number"
      ]
    end

    # define attributes for inner CreditCard type
    class CreditCard < Base
      def self.known_attributes
        [
          "number",
          "last_four",
          "type",
          "verification_value",
          "month",
          "year",
          "start_month",
          "start_year",
          "issue_number"
        ]
      end
    end

    # initialize associations
    def initialize(attributes = {}, persisted = true)
      attributes = attributes.with_indifferent_access
      attributes[:credit_card] ||= {}
      super(attributes, persisted)
    end

    def update_only
      true
    end
  end
end