require 'spec_helper'

module Recurly
  describe Credit do
    context "new record" do
      subject{Credit.new}

      it { should respond_to(:id)}
      it { should respond_to(:account_code)}
      it { should respond_to(:amount_in_cents)}
      it { should respond_to(:start_date)}
      it { should respond_to(:end_date)}
      it { should respond_to(:description)}
      it { should respond_to(:created_at)}
    end

  end
end