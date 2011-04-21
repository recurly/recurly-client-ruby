require 'spec_helper'

module Recurly
  describe BillingInfo do
    context "new record" do
      subject{BillingInfo.new}

      it { should respond_to(:first_name)}
      it { should respond_to(:last_name)}
      it { should respond_to(:address1)}
      it { should respond_to(:address2)}
      it { should respond_to(:city)}
      it { should respond_to(:state)}
      it { should respond_to(:zip)}
      it { should respond_to(:country)}
      it { should respond_to(:phone)}
      it { should respond_to(:ip_address)}
      it { should respond_to(:vat_number)}

      context "embedded credit card" do
        before(:each) do
          @credit_card = subject.credit_card
        end

        it{ @credit_card.should respond_to(:number)}
        it{ @credit_card.should respond_to(:last_four)}
        it{ @credit_card.should respond_to(:type)}
        it{ @credit_card.should respond_to(:verification_value)}
        it{ @credit_card.should respond_to(:month)}
        it{ @credit_card.should respond_to(:year)}
        it{ @credit_card.should respond_to(:start_month)}
        it{ @credit_card.should respond_to(:start_year)}
        it{ @credit_card.should respond_to(:issue_number)}

      end

    end
  end
end