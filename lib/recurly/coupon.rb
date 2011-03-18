module Recurly
  class Coupon < AccountBase
    self.element_name = "coupon"

    def self.known_attributes
      [
        "coupon_code",
        "redeemed_at"
      ]
    end

  end
end
