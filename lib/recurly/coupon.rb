module Recurly
  class Coupon < RecurlyAccountBase
    self.element_name = "coupon"

    def self.known_attributes
      [
        "coupon_code",
        "redeemed_at"
      ]
    end

  end
end
