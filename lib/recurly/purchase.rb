module Recurly
  # The Purchase object works a slightly differently than the rest of the models.
  # You build up the purchase data into an object then pass to either:
  # {Purchase.invoice!} or {Purchase.preview!} and it will
  # return an {Invoice}.
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
  # You can also pass in adjustments and invoicing data to be passed to the invoice.
  # @example
  #   require 'securerandom'
  #
  #   purchase = Recurly::Purchase.new({
  #     currency: 'USD',
  #     collection_method: :automatic,
  #     account: {
  #       account_code: SecureRandom.uuid,
  #       billing_info: {
  #         first_name: 'Benjamin',
  #         last_name: 'Du Monde',
  #         address1: '400 Alabama St',
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
  #         product_code: 'product_2'
  #         unit_amount_in_cents: 3000,
  #         quantity: 5,
  #         revenue_schedule_type: :at_invoice
  #       }
  #     ]
  #   })
  #
  #   begin
  #     preview_invoice = Recurly::Purchase.preview!(purchase)
  #     puts preview_invoice.inspect
  #   rescue Recurly::Resource::Invalid => e
  #     # Invalid data
  #   end
  #
  #   begin
  #     invoice = Recurly::Purchase.invoice!(purchase)
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

    define_attribute_methods %w(
      currency
      collection_method
      po_number
      net_terms
      coupon_codes
      terms_and_conditions
      customer_notes
      vat_reverse_charge_notes
    )

    class << self

      # Generate an invoice for the purchase and run any needed transactions
      #
      # @param purchase [Purchase] The purchase data for the request
      # @return [Invoice] The new invoice representing this purchase
      # @raise [Invalid] Raised if the account cannot be invoiced.
      # @raise [Transaction::Error] Raised if the transaction failed
      def invoice!(purchase)
        post(purchase, collection_path)
      end

      # Generate a preview invoice for the purchase. Runs validations
      # but does not run any transactions.
      #
      # @param purchase [Purchase] The purchase data for the request
      # @return [Invoice] The new invoice representing this purchase
      # @raise [Invalid] Raised if the account cannot be invoiced.
      def preview!(purchase)
        post(purchase, "#{collection_path}/preview")
      end

      def post(purchase, path)
        response = API.send(:post, path, purchase.to_xml)
        Invoice.from_response(response)
      rescue API::UnprocessableEntity => e
        purchase.apply_errors(e)
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
