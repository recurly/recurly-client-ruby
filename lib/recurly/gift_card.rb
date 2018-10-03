module Recurly
  class GiftCard < Resource
    # @return [Invoice, nil]
    belongs_to :invoice

    # @return [Account, nil] The Account belonging to the gifter
    belongs_to :gifter_account, class_name: :Account, readonly: false

    # @return [Account, nil] The Account belonging to the recipient of the gift
    belongs_to :recipient_account, class_name: :Account, readonly: false

    # @return [Delivery, nil] Delivery information of the recipient.
    has_one :delivery, class_name: :Delivery, readonly: false

    # @return [Invoice, nil] The credit invoice for the gift card redemption.
    has_one :redemption_invoice, class_name: :Invoice, readonly: true

    # @return [Invoice, nil] The charge invoice for the gift card redemption.
    has_one :purchase_invoice, class_name: :Invoice, readonly: true

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
      gifter_account_code
      recipient_account_code
      invoice_number
    )
    alias to_param id

    # Preview a GiftCard given some attributes
    #
    # @param [Hash] attributes for the gift card
    # @return [GiftCard] The resulting preview GiftCard
    def self.preview(attributes = {})
      new(attributes) { |record| record.preview }
    end

    # Preview the GiftCard. Runs and validates the GiftCard but
    # does not persist it. Errors are applied to the GiftCard if there
    # are any errors.
    def preview
      clear_errors
      @response = API.send(:post, "#{path}/preview", to_xml)
      reload response
    rescue API::UnprocessableEntity => e
      apply_errors e
    end

    # Redeem this GiftCard on the given account.
    #
    # @param [String] Recipient's account code
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
