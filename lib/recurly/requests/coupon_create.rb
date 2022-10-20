# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Requests
    class CouponCreate < Request
      
      # @!attribute applies_to_all_items
      #   @return [Boolean] To apply coupon to Items in your Catalog, include a list of `item_codes` in the request that the coupon will apply to. Or set value to true to apply to all Items in your Catalog. The following values are not permitted when `applies_to_all_items` is included: `free_trial_amount` and `free_trial_unit`. 
      define_attribute :applies_to_all_items, :Boolean
      
      # @!attribute applies_to_all_plans
      #   @return [Boolean] The coupon is valid for all plans if true. If false then `plans` will list the applicable plans.
      define_attribute :applies_to_all_plans, :Boolean
      
      # @!attribute applies_to_non_plan_charges
      #   @return [Boolean] The coupon is valid for one-time, non-plan charges if true.
      define_attribute :applies_to_non_plan_charges, :Boolean
      
      # @!attribute code
      #   @return [String] The code the customer enters to redeem the coupon.
      define_attribute :code, String
      
      # @!attribute coupon_type
      #   @return [String] Whether the coupon is "single_code" or "bulk". Bulk coupons will require a `unique_code_template` and will generate unique codes through the `/generate` endpoint.
      define_attribute :coupon_type, String
      
      # @!attribute currencies
      #   @return [Array[CouponPricing]] Fixed discount currencies by currency. Required if the coupon type is `fixed`. This parameter should contain the coupon discount values
      define_attribute :currencies, Array, {:item_type=>:CouponPricing}
      
      # @!attribute discount_percent
      #   @return [Integer] The percent of the price discounted by the coupon.  Required if `discount_type` is `percent`.
      define_attribute :discount_percent, Integer
      
      # @!attribute discount_type
      #   @return [String] The type of discount provided by the coupon (how the amount discounted is calculated)
      define_attribute :discount_type, String
      
      # @!attribute duration
      #   @return [String] This field does not apply when the discount_type is `free_trial`. - "single_use" coupons applies to the first invoice only. - "temporal" coupons will apply to invoices for the duration determined by the `temporal_unit` and `temporal_amount` attributes. - "forever" coupons will apply to invoices forever. 
      define_attribute :duration, String
      
      # @!attribute free_trial_amount
      #   @return [Integer] Sets the duration of time the `free_trial_unit` is for. Required if `discount_type` is `free_trial`.
      define_attribute :free_trial_amount, Integer
      
      # @!attribute free_trial_unit
      #   @return [String] Description of the unit of time the coupon is for. Used with `free_trial_amount` to determine the duration of time the coupon is for.  Required if `discount_type` is `free_trial`.
      define_attribute :free_trial_unit, String
      
      # @!attribute hosted_description
      #   @return [String] This description will show up when a customer redeems a coupon on your Hosted Payment Pages, or if you choose to show the description on your own checkout page.
      define_attribute :hosted_description, String
      
      # @!attribute invoice_description
      #   @return [String] Description of the coupon on the invoice.
      define_attribute :invoice_description, String
      
      # @!attribute item_codes
      #   @return [Array[String]] List of item codes to which this coupon applies. Sending `item_codes` is only permitted when `applies_to_all_items` is set to false. The following values are not permitted when `item_codes` is included: `free_trial_amount` and `free_trial_unit`. 
      define_attribute :item_codes, Array, {:item_type=>String}
      
      # @!attribute max_redemptions
      #   @return [Integer] A maximum number of redemptions for the coupon. The coupon will expire when it hits its maximum redemptions.
      define_attribute :max_redemptions, Integer
      
      # @!attribute max_redemptions_per_account
      #   @return [Integer] Redemptions per account is the number of times a specific account can redeem the coupon. Set redemptions per account to `1` if you want to keep customers from gaming the system and getting more than one discount from the coupon campaign.
      define_attribute :max_redemptions_per_account, Integer
      
      # @!attribute name
      #   @return [String] The internal name for the coupon.
      define_attribute :name, String
      
      # @!attribute plan_codes
      #   @return [Array[String]] List of plan codes to which this coupon applies. Required if `applies_to_all_plans` is false. Overrides `applies_to_all_plans` when `applies_to_all_plans` is true. 
      define_attribute :plan_codes, Array, {:item_type=>String}
      
      # @!attribute redeem_by_date
      #   @return [String] The date and time the coupon will expire and can no longer be redeemed. Time is always 11:59:59, the end-of-day Pacific time.
      define_attribute :redeem_by_date, String
      
      # @!attribute redemption_resource
      #   @return [String] Whether the discount is for all eligible charges on the account, or only a specific subscription.
      define_attribute :redemption_resource, String
      
      # @!attribute temporal_amount
      #   @return [Integer] If `duration` is "temporal" than `temporal_amount` is an integer which is multiplied by `temporal_unit` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_amount, Integer
      
      # @!attribute temporal_unit
      #   @return [String] If `duration` is "temporal" than `temporal_unit` is multiplied by `temporal_amount` to define the duration that the coupon will be applied to invoices for.
      define_attribute :temporal_unit, String
      
      # @!attribute unique_code_template
      #   @return [String] On a bulk coupon, the template from which unique coupon codes are generated. - You must start the template with your coupon_code wrapped in single quotes. - Outside of single quotes, use a 9 for a character that you want to be a random number. - Outside of single quotes, use an "x" for a character that you want to be a random letter. - Outside of single quotes, use an * for a character that you want to be a random number or letter. - Use single quotes ' ' for characters that you want to remain static. These strings can be alphanumeric and may contain a - _ or +. For example: "'abc-'****'-def'" 
      define_attribute :unique_code_template, String
      
    end
  end
end
