# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class Coupon < Resource

      # @!attribute applies_to_all_plans
      #   @return [Boolean] The coupon is valid for all plans if true. If false then `plans` and `plans_names` will list the applicable plans.
      define_attribute :applies_to_all_plans, :Boolean

      # @!attribute applies_to_non_plan_charges
      #   @return [Boolean] The coupon is valid for one-time, non-plan charges if true.
      define_attribute :applies_to_non_plan_charges, :Boolean

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute coupon_type
      #   @return [String] Whether the coupon is "single_code" or "bulk". Bulk coupons will require a `unique_code_template` and will generate unique codes through the `/generate` endpoint.
      define_attribute :coupon_type, String, { :enum => ["single_code", "bulk"] }

      # @!attribute [r] created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime, { :read_only => true }

      # @!attribute discount
      #   @return [CouponDiscount]
      define_attribute :discount, :CouponDiscount

      # @!attribute duration
      #   @return [String] - "single_use" coupons applies to the first invoice only. - "temporal" coupons will apply to invoices for the duration determined by the `temporal_unit` and `temporal_amount` attributes.
      define_attribute :duration, String, { :enum => ["forever", "single_use", "temporal"] }

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute free_trial_amount
      #   @return [Integer] Sets the duration of time the `free_trial_unit` is for.
      define_attribute :free_trial_amount, Integer

      # @!attribute free_trial_unit
      #   @return [String] Description of the unit of time the coupon is for. Used with `free_trial_amount` to determine the duration of time the coupon is for.
      define_attribute :free_trial_unit, String, { :enum => ["day", "week", "month"] }

      # @!attribute hosted_page_description
      #   @return [String] This description will show up when a customer redeems a coupon on your Hosted Payment Pages, or if you choose to show the description on your own checkout page.
      define_attribute :hosted_page_description, String

      # @!attribute [r] id
      #   @return [String] Coupon ID
      define_attribute :id, String, { :read_only => true }

      # @!attribute invoice_description
      #   @return [String] Description of the coupon on the invoice.
      define_attribute :invoice_description, String

      # @!attribute max_redemptions
      #   @return [Integer] A maximum number of redemptions for the coupon. The coupon will expire when it hits its maximum redemptions.
      define_attribute :max_redemptions, Integer

      # @!attribute max_redemptions_per_account
      #   @return [Integer] Redemptions per account is the number of times a specific account can redeem the coupon. Set redemptions per account to `1` if you want to keep customers from gaming the system and getting more than one discount from the coupon campaign.
      define_attribute :max_redemptions_per_account, Integer

      # @!attribute name
      #   @return [String] The internal name for the coupon.
      define_attribute :name, String

      # @!attribute [r] object
      #   @return [String] Object type
      define_attribute :object, String, { :read_only => true }

      # @!attribute plans
      #   @return [Array[PlanMini]] Plans
      define_attribute :plans, Array, { :item_type => :PlanMini }

      # @!attribute plans_names
      #   @return [Array[String]] TODO
      define_attribute :plans_names, Array, { :item_type => String }

      # @!attribute redeem_by
      #   @return [DateTime] The date and time the coupon will expire and can no longer be redeemed. Time is always 11:59:59, the end-of-day Pacific time.
      define_attribute :redeem_by, DateTime

      # @!attribute redemption_resource
      #   @return [String] Whether the discount is for all eligible charges on the account, or only a specific subscription.
      define_attribute :redemption_resource, String, { :enum => ["account", "subscription"] }

      # @!attribute state
      #   @return [String] Indicates if the coupon is redeemable, and if it is not, why.
      define_attribute :state, String, { :enum => ["redeemable", "maxed_out", "expired"] }

      # @!attribute temporal_amount
      #   @return [Integer] If `duration` is "temporal" than `temporal_amount` is an integer which is multiplied by `temporal_unit` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_amount, Integer

      # @!attribute temporal_unit
      #   @return [String] If `duration` is "temporal" than `temporal_unit` is multiplied by `temporal_amount` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_unit, String, { :enum => ["day", "week", "month", "year"] }

      # @!attribute [r] unique_coupon_codes_count
      #   @return [Integer] When this number reaches `max_redemptions` the coupon will no longer be redeemable.
      define_attribute :unique_coupon_codes_count, Integer, { :read_only => true }

      # @!attribute [r] updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime, { :read_only => true }
    end
  end
end
