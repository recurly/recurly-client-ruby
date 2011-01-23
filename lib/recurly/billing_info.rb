module Recurly
  class BillingInfo < AccountBase
    self.element_name = "billing_info"

    # initialize fields with blank data
    def initialize(attributes = {})

      attributes[:first_name] ||= nil
      attributes[:last_name] ||= nil
      attributes[:address1] ||= nil
      attributes[:address2] ||= nil
      attributes[:city] ||= nil
      attributes[:state] ||= nil
      attributes[:zip] ||= nil
      attributes[:country] ||= nil
      attributes[:phone] ||= nil
      attributes[:ip_address] ||= nil

      attributes[:credit_card] ||= {}
      attributes[:credit_card][:number] ||= nil
      attributes[:credit_card][:verification_value] ||= nil
      attributes[:credit_card][:month] ||= nil
      attributes[:credit_card][:year] ||= nil
      attributes[:credit_card][:start_month] ||= nil
      attributes[:credit_card][:start_year] ||= nil
      attributes[:credit_card][:issue_number] ||= nil

      super(attributes)
    end

    def update_only
      true
    end
  end
end