module Recurly
  class GiftCard < Resource
    belongs_to :invoice
    belongs_to :gifter_account, class_name: :Account, readonly: false
    belongs_to :recipient_account, class_name: :Account, readonly: false
    has_one :delivery, readonly: false

    define_attribute_methods %w(
      balance_in_cents
      currency
      created_at
      delivered_at
      id
      product_code
      redeemed_at
      redemption_code
      unit_amount_in_cents
      updated_at
      canceled_at
    )

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

    def redeem(recipient_account_code)
      clear_errors
      xml = <<-XML
        <recipient_account>
            <account_code>#{recipient_account_code}</account_code>
        </recipient_account>
      XML
      @response = API.send(:post, "#{self.class.collection_path}/#{redemption_code}/redeem", xml)
      reload response
    rescue API::UnprocessableEntity => e
      apply_errors e
    end

    private

    def xml_keys
      keys = super
      keys << 'redemption_code' if redemption_code? && !redemption_code_changed?
      keys.sort
    end
  end
end
