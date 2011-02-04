require 'spec_helper'

module Recurly
  describe Transaction do
    context "new record" do
      subject{Transaction.new}

      it { should respond_to(:id)}
      it { should respond_to(:account_code)}
      it { should respond_to(:type)}
      it { should respond_to(:action)}
      it { should respond_to(:date)}
      it { should respond_to(:amount_in_cents)}
      it { should respond_to(:status)}
      it { should respond_to(:message)}
      it { should respond_to(:reference)}
      it { should respond_to(:ccv_result)}
      it { should respond_to(:avs_result)}
      it { should respond_to(:avs_result_street)}
      it { should respond_to(:avs_result_postal)}
      it { should respond_to(:test)}
      it { should respond_to(:voidable)}
      it { should respond_to(:refundable)}

      # TODO: embedded account
      # TODO: embedded billing_info
      # TODO: embedded credit_card

    end

  end
end