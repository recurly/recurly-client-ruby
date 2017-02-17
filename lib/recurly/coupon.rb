module Recurly
  class Coupon < Resource
    BULK = 'bulk'.freeze
    SINGLE_CODE = 'single_code'.freeze

    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Coupon>] A pager that yields +$1+ coupons.
    scope :redeemable, :state => :redeemable
    scope :expired,    :state => :expired
    scope :maxed_out,  :state => :maxed_out

    # @return [Pager<Redemption>, []]
    has_many :redemptions

    # @return [Pager<Coupon>, []]
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
    # @param currency [String]
    # @param opts [Hash]
    # @example
    #   coupon = Coupon.find coupon_code
    #   coupon.redeem account_code, 'USD', subscription_uuid: 'ab3b1dbabc3195'
    #
    #   coupon = Coupon.find coupon_code
    #   account = Account.find account_code
    #   coupon.redeem account
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

    def generate(amount)
      builder = XML.new("<coupon/>")
      builder.add_element 'number_of_unique_codes', amount

      resp = follow_link(:generate,
        :body => builder.to_s
      )

      Pager.new(Recurly::Coupon, uri: resp['location'], parent: self, etag: resp['ETag'])
    end

    def redeem! account_code, currency = nil
      redemption = redeem account_code, currency
      raise Invalid.new(redemption) unless redemption.persisted?
      redemption
    end

    def restore!
      return false unless link? :restore
      reload follow_link(:restore, body: self.to_xml(delta: true))
    end

    def unlimited_redemptions_per_account?
      !max_redemptions_per_account
    end
  end
end
