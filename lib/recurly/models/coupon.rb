# frozen_string_literal: true

module Recurly
  # Represents a Coupon in Recurly
  class Coupon < Recurly::Model
    def self.list(params:)
      client.list_coupons(params: params)
    end

    def self.get(id:)
      client.get_coupon(coupon_id: id)
    end
  end
end
