module Recurly
  class GiftCard < Resource

    belongs_to :invoice
    belongs_to :gifter_account, class_name: :Account, readonly: false
    belongs_to :recipient_account, class_name: :Account, readonly: false

    define_attribute_methods %w(
      id
      currency
      unit_amount_in_cents
      product_code
      redemption_code
      balance_in_cents
      delivery
      created_at
      updated_at
      delivered_at
      redeemed_at
    )

    #delivery
    #  method
    #  email_address
    #  first_name
    #  last_name
    #  address
    #    address1
    #    address2
    #    city
    #    state
    #    zip
    #    country
    #    phone
    #  gifter_name
    #  personal_message

    def self.preview(attributes = {})
      new(attributes) { |record| record.preview }
    end

    def preview
      clear_errors
      @response = API.send(:post, "#{path}/preview", to_xml)
      reload response
    rescue API::UnprocessableEntity => e
      apply_errors e
    end

  end
end
