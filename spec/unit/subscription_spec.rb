require 'spec_helper'

module Recurly
  describe Subscription do
    context "new record" do
      subject{Subscription.new}

      it { should respond_to(:plan_code)}
      it { should respond_to(:coupon_code)}
      it { should respond_to(:unit_amount_in_cents)}
      it { should respond_to(:quantity)}
      it { should respond_to(:trial_ends_at)}

      # TODO: embedded account

      # TODO: embedded billing_info

      # TODO: embedded credit_card

      # TODO: embedded addons list

    end

  end
end