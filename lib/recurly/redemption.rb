module Recurly
  # Redemptions are not top-level resources, but they can be accessed (and
  # created) through {Coupon} instances.
  #
  # @example
  #   coupon = Coupon.find "summer2011"
  #   coupon.redemptions.each { |r| p r }
  #   coupon.redeem Account.find("groupon_lover")
  class Redemption < Resource
    # @return [Coupon]
    belongs_to :coupon
    # @return [Account]
    belongs_to :account, :readonly => false

    # @return [Subscription]
    belongs_to :subscription

    define_attribute_methods %w(
      uuid
      single_use
      total_discounted_in_cents
      currency
      state
      created_at
    )

    def destroy_uri
      uri + "s/#{uuid}"
    end

    def save
      return false if persisted?
      copy_from coupon.redeem account, currency
      true
    rescue Recurly::API::UnprocessableEntity => e
      apply_errors e
      false
    end

    # Redemptions are only writeable through {Coupon} instances.
    embedded!
  end
end
