require 'spec_helper'

module Recurly
  describe Coupon do
    context "new record" do
      subject{Coupon.new}

      it { should respond_to(:coupon_code)}
      it { should respond_to(:redeemed_at)}
    end

  end
end