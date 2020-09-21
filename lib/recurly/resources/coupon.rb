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

      # @!attribute bulk_coupon_code
      #   @return [String] The Coupon code of the parent Bulk Coupon
      define_attribute :bulk_coupon_code, String

      # @!attribute bulk_coupon_id
      #   @return [String] The Coupon ID of the parent Bulk Coupon
      define_attribute :bulk_coupon_id, String

      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String

      # @!attribute coupon_type
      #   @return [String] Whether the coupon is "single_code" or "bulk". Bulk coupons will require a `unique_code_template` and will generate unique codes through the `/generate` endpoint.
      define_attribute :coupon_type, String

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute discount
      #   @return [CouponDiscount] Details of the discount a coupon applies. Will contain a `type` property and one of the following properties: `percent`, `fixed`, `trial`.
      define_attribute :discount, :CouponDiscount

      # @!attribute duration
      #   @return [String] - "single_use" coupons applies to the first invoice only. - "temporal" coupons will apply to invoices for the duration determined by the `temporal_unit` and `temporal_amount` attributes.
      define_attribute :duration, String

      # @!attribute expired_at
      #   @return [DateTime] The date and time the coupon was expired early or reached its `max_redemptions`.
      define_attribute :expired_at, DateTime

      # @!attribute free_trial_amount
      #   @return [Integer] Sets the duration of time the `free_trial_unit` is for.
      define_attribute :free_trial_amount, Integer

      # @!attribute free_trial_unit
      #   @return [String] Description of the unit of time the coupon is for. Used with `free_trial_amount` to determine the duration of time the coupon is for.
      define_attribute :free_trial_unit, String

      # @!attribute hosted_page_description
      #   @return [String] This description will show up when a customer redeems a coupon on your Hosted Payment Pages, or if you choose to show the description on your own checkout page.
      define_attribute :hosted_page_description, String

      # @!attribute id
      #   @return [String] Coupon ID
      define_attribute :id, String

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

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute plans
      #   @return [Array[PlanMini]] A list of plans for which this coupon applies. This will be `null` if `applies_to_all_plans=true`.
      define_attribute :plans, Array, { :item_type => :PlanMini }

      # @!attribute plans_names
      #   @return [Array[String]] A list of plan names for which this coupon applies.
      define_attribute :plans_names, Array, { :item_type => String }

      # @!attribute redeem_by
      #   @return [DateTime] The date and time the coupon will expire and can no longer be redeemed. Time is always 11:59:59, the end-of-day Pacific time.
      define_attribute :redeem_by, DateTime

      # @!attribute redeemed_at
      #   @return [DateTime] The date and time the unique coupon code was redeemed. This is only present for bulk coupons.
      define_attribute :redeemed_at, DateTime

      # @!attribute redemption_resource
      #   @return [String] Whether the discount is for all eligible charges on the account, or only a specific subscription.
      define_attribute :redemption_resource, String

      # @!attribute state
      #   @return [String] Indicates if the coupon is redeemable, and if it is not, why.
      define_attribute :state, String

      # @!attribute temporal_amount
      #   @return [Integer] If `duration` is "temporal" than `temporal_amount` is an integer which is multiplied by `temporal_unit` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_amount, Integer

      # @!attribute temporal_unit
      #   @return [String] If `duration` is "temporal" than `temporal_unit` is multiplied by `temporal_amount` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_unit, String

      # @!attribute unique_code_template
      #   @return [String] On a bulk coupon, the template from which unique coupon codes are generated.
      define_attribute :unique_code_template, String

      # @!attribute unique_coupon_codes_count
      #   @return [Integer] When this number reaches `max_redemptions` the coupon will no longer be redeemable.
      define_attribute :unique_coupon_codes_count, Integer

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime
    end
  end
end
