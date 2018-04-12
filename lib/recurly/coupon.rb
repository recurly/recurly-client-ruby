module Recurly

  # Recurly Documentation: https://dev.recurly.com/docs/list-active-coupons
  class Coupon < Resource
    BULK = 'bulk'.freeze
    SINGLE_CODE = 'single_code'.freeze

    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Coupon>] A pager that yields +$1+ coupons.
    scope :redeemable, :state => :redeemable
    scope :expired,    :state => :expired
    scope :maxed_out,  :state => :maxed_out

    # @return [Pager<Redemption>, []] A pager that yields Redemptions
    has_many :redemptions

    # @return [Pager<Coupon>, []] A pager that yields coupon-code type Coupons
    has_many :unique_coupon_codes, class_name: :Coupon

    define_attribute_methods %w(
      id
      coupon_code
      name
      state
      discount_type
      discount_percent
      discount_in_cents
      redeem_by_date
      single_use
      applies_for_months
      duration
      temporal_unit
      temporal_amount
      max_redemptions
      max_redemptions_per_account
      applies_to_all_plans
      created_at
      updated_at
      plan_codes
      description
      invoice_description
      applies_to_non_plan_charges
      redemption_resource
      coupon_type
      unique_template_code
      free_trial_amount
      free_trial_unit
    )
    alias to_param coupon_code

    # Redeem a coupon with a given account or account code.
    #
    # @return [true]
    # @param account_or_code [Account, String]
    # @param currency [String] Three-letter currency code
    # @param extra_opts [Hash] extra options that go into the {Redemption}
    # @example
    #   coupon = Coupon.find(coupon_code)
    #   coupon.redeem(account_code, 'USD', subscription_uuid: 'ab3b1dbabc3195')
    #
    #   coupon = Coupon.find(coupon_code)
    #   account = Account.find(account_code)
    #   coupon.redeem(account)
    def redeem account_or_code, currency = nil, extra_opts={}
      return false unless link? :redeem

      account_code = if account_or_code.is_a? Account
        account_or_code.account_code
      else
        account_or_code
      end

      redemption_options = {
        :account_code => account_code,
        :currency     => currency || Recurly.default_currency
      }.merge(extra_opts)

      redemption = Redemption.new(redemption_options)

      Redemption.from_response follow_link(:redeem,
        :body => redemption.to_xml
      )
    rescue API::UnprocessableEntity => e
      redemption.apply_errors e
      redemption
    end

    # Generate unique coupon codes on the server. This is based on the unique_template_code.
    #
    # @param amount [Integer]
    # @return [Pager<Coupon>] A pager that yields the coupon-code type Coupons
    # @example
    #   unique_codes = coupon.generate(10)
    #   unique_codes.each do |c|
    #     puts c.coupon_code
    #   end
    def generate(amount)
      builder = XML.new("<coupon/>")
      builder.add_element 'number_of_unique_codes', amount

      resp = follow_link(:generate,
        :body => builder.to_s
      )

      Pager.new(Recurly::Coupon, uri: resp['location'], parent: self, etag: resp['ETag'])
    end

    # Redeem a coupon on the given account code
    #
    # @param account_code [String] Acccount's account code
    # @param currency [String] Three-letter currency code
    # @raise [Invalid] If the coupon cannot be redeemed
    # @return [Redemption] The Coupon Redemption
    def redeem!(account_code, currency = nil)
      redemption = redeem(account_code, currency)
      raise Invalid.new(self) unless redemption && redemption.persisted?
      redemption
    end

    # Restores the coupon
    def restore!
      return false unless link? :restore
      reload follow_link(:restore, body: self.to_xml(delta: true))
    end

    # Will return true if there are no limits on number of redemptions for this Coupon.
    #
    # @return [true, false]
    def unlimited_redemptions_per_account?
      !max_redemptions_per_account
    end
  end
end
