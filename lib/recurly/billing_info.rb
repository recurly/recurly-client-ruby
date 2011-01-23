module Recurly
  class BillingInfo < AccountBase
    self.element_name = "billing_info"

    def self.default_attributes
      [
        :first_name,
        :last_name,
        :address1,
        :address2,
        :city,
        :state,
        :zip,
        :country,
        :phone,
        :ip_address
      ]
    end

    def self.credit_card_attributes
      [
        :number,
        :verification_value,
        :month,
        :year,
        :start_month,
        :start_year,
        :issue_number
      ]
    end

    # initialize fields with blank data
    def initialize(attributes = {})

      # set default credit card attributes
      attributes[:credit_card] ||= {}
      if attributes[:credit_card].is_a?(Hash)
        self.class.credit_card_attributes.each do |attribute|
          attributes[:credit_card][attribute] ||= nil
        end
      end

      super(attributes)
    end

    def update_only
      true
    end
  end
end