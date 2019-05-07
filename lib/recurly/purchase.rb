module Recurly
  # The Purchase object works in a slightly different way than the rest of the models.
  # You build up the purchase data into an object then pass to either:
  # {Purchase.invoice!} or {Purchase.preview!} and it will
  # return an {InvoiceCollection}.
  #
  # You can build your purchase object with a new account or an existing account.
  # For an existing account, you just need an account_code:
  #   Recurly::Purchase.new({account: {account_code: 'myexistingaccount'}})
  # or
  #   account = Recurly::Account.find('existing_account')
  #   Recurly::Purchase.new({account: account})
  # or
  #   account = Recurly::Account.find('existing_account')
  #   purchase = Recurly::Purchase.new
  #   purchase.account = account
  #
  # For a new account, you can pass in {Account} data, {BillingInfo} data, etc
  # in the same way you would when creating a {Subscription} with a new account.
  #
  # You can also pass in adjustments and invoicing data to be added to the invoice.
  #
  # There are multiple ways to set the shipping addresses:
  # 1. Use {Purchase#shipping_address_id} If you want to apply an existing shipping
  #    address to all subscriptions, adjustments, and shipping fees in this purchase.
  # 2. Add multiple shipping addresses to {Account#shipping_addresses}. The last
  #    address in the list will apply to all subscriptions and adjustments
  #    in this purchase.
  # 3. Use {Subscription#shipping_address_id} or {Subscription#shipping_address}
  #    to set a shipping address for only the subscription.
  # 4. Use {Adjustment#shipping_address_id} or {Adjustment#shipping_address}
  #    to set a shipping address for only the adjustment.
  # 5. Use {ShippingFee#shipping_address_id} or {ShippingFee#shipping_address}
  #    to set a shipping address for only the shipping fee. If there are multiple
  #    shipping fees on a single purchase, each can have its own shipping address.
  #    This way, if you ship different adjustments to multiple addresses, the
  #    shipping fees on the purchase can be associated with the same address
  #    as the adjustment.
  #
  # @example
  #   require 'securerandom'
  #
  #   purchase = Recurly::Purchase.new(
  #     currency: 'USD',
  #     collection_method: :automatic,
  #     account: {
  #       account_code: SecureRandom.uuid,
  #       shipping_addresses: [
  #         {
  #           first_name: 'Benjamin',
  #           last_name: 'Du Monde',
  #           address1: '400 Dolores St.',
  #           city: 'San Francisco',
  #           state: 'CA',
  #           zip: '94110',
  #           country: 'US',
  #           nickname: 'Home'
  #         }
  #       ],
  #       billing_info: {
  #         first_name: 'Benjamin',
  #         last_name: 'Du Monde',
  #         address1: '400 Alabama St.',
  #         city: 'San Francisco',
  #         state: 'CA',
  #         zip: '94110',
  #         country: 'US',
  #         number: '4111-1111-1111-1111',
  #         month: 12,
  #         year: 2019,
  #       }
  #     },
  #     adjustments: [
  #       {
  #          product_code: 'product_1',
  #          unit_amount_in_cents: 1000,
  #          quantity: 1,
  #          revenue_schedule_type: :at_invoice
  #       },
  #       {
  #         product_code: 'product_2',
  #         unit_amount_in_cents: 3000,
  #         quantity: 5,
  #         revenue_schedule_type: :at_invoice
  #       }
  #     ],
  #     shipping_fees: [
  #       {
  #         shipping_method_code: 'fast_fast_fast',
  #         shipping_amount_in_cents: '999'
  #       }
  #     ]
  #   )
  #
  #   begin
  #     preview_collection = Recurly::Purchase.preview!(purchase)
  #     puts preview_collection.inspect
  #   rescue Recurly::Resource::Invalid => e
  #     # Invalid data
  #   end
  #
  #   begin
  #     invoice_collection = Recurly::Purchase.invoice!(purchase)
  #     puts invoice_collection.inspect
  #   rescue Recurly::Resource::Invalid => e
  #     # Invalid data
  #   rescue Recurly::Transaction::DeclinedError => e
  #     # Display e.message and/or subscription (and associated) errors...
  #   rescue Recurly::Transaction::RetryableError => e
  #     # You should be able to attempt to save this again later.
  #   rescue Recurly::Transaction::Error => e
  #     # Fallback transaction error
  #     # e.transaction
  #     # e.transaction_error_code
  #   end
  class Purchase < Resource
    # @return [[Adjustment], nil]
    has_many :adjustments, class_name: :Adjustment, readonly: false

    # @return [Account, nil]
    has_one :account, class_name: :Account, readonly: false

    # @return [GiftCard, nil]
    has_one :gift_card, class_name: :GiftCard, readonly: false

    # @return [[Subscription], nil]
    has_many :subscriptions, class_name: :Subscription, readonly: false

    # @return [[ShippingFee], nil]
    has_many :shipping_fees, class_name: :ShippingFee, readonly: false

    define_attribute_methods %w(
      currency
      collection_method
      po_number
      net_terms
      coupon_codes
      terms_and_conditions
      customer_notes
      vat_reverse_charge_notes
      shipping_address_id
      gateway_code
    )

    class << self

      # Generate an invoice for the purchase and run any needed transactions.
      #
      # @param purchase [Purchase] The purchase data for the request.
      # @return [InvoiceCollection] The saved invoice(s) representing this purchase.
      # @raise [Invalid] Raised if the purchase cannot be invoiced.
      # @raise [Transaction::Error] Raised if the transaction failed.
      def invoice!(purchase)
        post(purchase, collection_path)
      end

      # Generate a preview invoice for the purchase. Runs validations
      # but does not run any transactions.
      #
      # @param purchase [Purchase] The purchase data for the request.
      # @return [InvoiceCollection] The preview invoice(s) representing this purchase.
      # @raise [Invalid] Raised if the purchase cannot be invoiced.
      def preview!(purchase)
        post(purchase, "#{collection_path}/preview")
      end

      # Generate an authorized invoice for the purchase. Runs validations
      # but does not run any transactions. This endpoint will create a
      # pending purchase that can be activated at a later time once payment
      # has been completed on an external source (e.g. Adyen's Hosted
      # Payment Pages).
      #
      # @param purchase [Purchase] The purchase data for the request.
      # @return [InvoiceCollection] The authorized invoice collection representing this purchase.
      # @raise [Invalid] Raised if the purchase cannot be invoiced.
      def authorize!(purchase)
        post(purchase, "#{collection_path}/authorize")
      end

      # Use for Adyen HPP transaction requests. Runs validations
      # but does not run any transactions.
      #
      # @param purchase [Purchase] The purchase data for the request.
      # @return [InvoiceCollection] The authorized invoice collection representing this purchase.
      # @raise [Invalid] Raised if the purchase cannot be invoiced.
      def pending!(purchase)
        post(purchase, "#{collection_path}/pending")
      end

      # Allows the merchant to cancel an authorization.
      #
      # @param transaction_uuid [String] The uuid for the transaction representing the authorization. Can typically be found at invoice_collection.charge_invoice.transactions.first.uuid.
      # @return [InvoiceCollection] The canceled invoice collection.
      # @raise [Invalid] Raised if the authorization cannot be canceled.
      def cancel!(transaction_uuid)
        post(nil, "#{collection_path}/transaction-uuid-#{transaction_uuid}/cancel")
      end

      # Allows the merchants to initiate a capture transaction tied to the original authorization.
      #
      # @param transaction_uuid [String] The uuid for the transaction representing the authorization. Can typically be found at invoice_collection.charge_invoice.transactions.first.uuid.
      # @return [InvoiceCollection] The captured invoice collection.
      # @raise [Invalid] Raised if the authorization cannot be captured.
      def capture!(transaction_uuid)
        post(nil, "#{collection_path}/transaction-uuid-#{transaction_uuid}/capture")
      end

      def post(purchase, path)
        body = purchase.nil? ? nil : purchase.to_xml
        response = API.send(:post, path, body)
        InvoiceCollection.from_response(response)
      rescue API::UnprocessableEntity => e
        purchase.apply_errors(e) if purchase
        Transaction::Error.validate!(e, nil)
        raise Resource::Invalid.new(purchase)
      end
    end

    # TODO
    # This is a temporary solution which allows us to
    # embed these resources in a purchase without changing their
    # interface. It will be removed once we get rid of default_currency.
    def to_xml(options = {})
      subscriptions.each {|s| s.currency = nil}
      adjustments.each   {|a| a.currency = nil}
      super(options)
    end

    # This object does not represent a model on the server side
    # so we do not need to expose these methods.
    protected(*%w(save save!))
    private_class_method(*%w(all find_each first paginate scoped where post create! create))
  end
end
