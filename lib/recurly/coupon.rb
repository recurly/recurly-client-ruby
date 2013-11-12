module Recurly
  class Coupon < Resource
    # @macro [attach] scope
    #   @scope class
    #   @return [Pager<Coupon>] A pager that yields +$1+ coupons.
    scope :redeemable, :state => :redeemable
    scope :expired,    :state => :expired
    scope :maxed_out,  :state => :maxed_out

    # @return [Pager<Redemption>, []]
    has_many :redemptions

    define_attribute_methods %w(
      coupon_code
      name
      state
      discount_type
      discount_percent
      discount_in_cents
      redeem_by_date
      single_use
      applies_for_months
      max_redemptions
      applies_to_all_plans
      created_at
      plan_codes
      description
      invoice_description
    )
    alias to_param coupon_code

    # Saves new records only.
    #
    # @return [true, false]
    # @raise [Recurly::Error] For persisted coupons.
    # @see Resource#save
    def save
      return super if new_record?
      raise Recurly::Error, "#{self.class.collection_name} cannot be updated"
    end

    # Redeem a coupon with a given account or account code.
    #
    # @return [true]
    # @param account_or_code [Account, String]
    # @example
    #   coupon = Coupon.find coupon_code
    #   coupon.redeem account_code
    #
    #   coupon = Coupon.find coupon_code
    #   account = Account.find account_code
    #   coupon.redeem account
    def redeem account_or_code, currency = nil
      return false unless link? :redeem

      account_code = if account_or_code.is_a? Account
        account_or_code.account_code
      else
        account_or_code
      end

      Redemption.from_response follow_link(:redeem,
        :body => (redemption = redemptions.new(
          :account_code => account_code,
          :currency     => currency || Recurly.default_currency
        )).to_xml
      )
    rescue API::UnprocessableEntity => e
      redemption.apply_errors e
      redemption
    end

    def redeem! account_code, currency = nil
      redemption = redeem account_code, currency
      raise Invalid.new(self) unless redemption.persisted?
      redemption
    end
  end
end
