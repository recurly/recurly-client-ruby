require 'spec_helper'

module Recurly
  describe Plan do
    context "new record" do
      subject{Plan.new}

      it { should respond_to(:plan_code)}
      it { should respond_to(:name)}
      it { should respond_to(:description)}
      it { should respond_to(:success_url)}
      it { should respond_to(:cancel_url)}
      it { should respond_to(:created_at)}

    end

  end
end