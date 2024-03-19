require 'spec_helper'

describe BillingInfo do
  describe "payment methods types" do
    describe "credit card" do
      let(:binfo) {
        BillingInfo.new(
          :first_name => "Larry",
          :last_name  => "David",
          :card_type  => "Visa",
          :last_four  => "1111",
          :city       => "Los Angeles",
          :state      => "CA",
          :card_network_preference => "Cartes Bancaires",
          :gateway_attributes => { account_reference: "ABC123" },
        )
      }
    
      it "must serialize" do
        binfo.gateway_token = "gatewaytoken123"
        binfo.gateway_code = "gatewaycode123"
        binfo.to_xml.must_equal <<XML.chomp
<billing_info>\
<card_network_preference>Cartes Bancaires</card_network_preference>\
<card_type>Visa</card_type>\
<city>Los Angeles</city>\
<first_name>Larry</first_name>\
<gateway_attributes>\
<account_reference>ABC123</account_reference>\
</gateway_attributes>\
<gateway_code>gatewaycode123</gateway_code>\
<gateway_token>gatewaytoken123</gateway_token>\
<last_four>1111</last_four>\
<last_name>David</last_name>\
<state>CA</state>\
</billing_info>
XML
      end
    end

    describe "ideal" do
      let(:ideal_billing_info) {
        BillingInfo.new(
          :first_name => "Larry",
          :last_name  => "David",
          :online_banking_payment_type => "ideal"
        )
      }
    
      it "must serialize" do
        ideal_billing_info.to_xml.must_equal <<XML.chomp
<billing_info>\
<first_name>Larry</first_name>\
<last_name>David</last_name>\
<online_banking_payment_type>ideal</online_banking_payment_type>\
</billing_info>
XML
      end
    end
  end

  describe ".find" do
    it "must return an account's billing info when available" do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      billing_info.must_be_instance_of BillingInfo
      billing_info.first_name.must_equal 'Larry'
      billing_info.last_name.must_equal 'David'
      billing_info.card_type.must_equal 'Visa'
      billing_info.last_four.must_equal '1111'
      billing_info.city.must_equal 'Los Angeles'
      billing_info.state.must_equal 'CA'
    end

    it "must return an accounts billing info as a bank account (last_four) when available" do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200-bank-account'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      billing_info.name_on_account.must_equal 'Larry David'
      billing_info.account_type.must_equal 'checking'
      billing_info.last_four.must_equal '3123'
      billing_info.routing_number.must_equal '12309812'
    end

    it "must return an account's billing info as IBAN (last_two) when available" do
      stub_api_request(
        :get, 'accounts/sepa1234567890/billing_info', 'billing_info/show-sepa-200'
      )
      billing_info = BillingInfo.find 'sepa1234567890'
      billing_info.name_on_account.must_equal 'Account Name'
      billing_info.last_two.must_equal '06'
    end

    it "must return an account's billing info as BACS (sort_code) when available" do
      stub_api_request(
        :get, 'accounts/bacs1234567890/billing_info', 'billing_info/show-bacs-200'
      )
      billing_info = BillingInfo.find 'bacs1234567890'
      billing_info.type.must_equal 'bacs'
      billing_info.sort_code.must_equal '200000'
    end

    it "must return an account's billing info as BECS (bsb_code) when available" do
      stub_api_request(
        :get, 'accounts/becs1234567890/billing_info', 'billing_info/show-becs-200'
      )
      billing_info = BillingInfo.find 'becs1234567890'
      billing_info.type.must_equal 'becs'
      billing_info.bsb_code.must_equal '082-082'
    end

    it "must raise an exception when unavailable" do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'accounts/show-404'
      )
      proc { BillingInfo.find 'abcdef1234567890' }.must_raise Resource::NotFound
    end

    describe "#cc_bin_country" do
      before do
        stub_api_request(
          :get, 'accounts/without-cc-bin/billing_info', 'billing_info/show-200'
        )
        stub_api_request(
          :get, 'accounts/with-cc-bin/billing_info', 'billing_info/show-200-cc-bin-country'
        )
      end

      it "is accessible as an attribute" do
        billing_info_without_cc_bin_country = BillingInfo.find 'without-cc-bin'
        billing_info_without_cc_bin_country.cc_bin_country.must_equal nil

        billing_info_with_cc_bin_country = BillingInfo.find 'with-cc-bin'
        billing_info_with_cc_bin_country.cc_bin_country.must_equal 'US'
      end
    end

    describe "#username" do
      before do
        stub_api_request(
          :get, 'accounts/venmo1234567890/billing_info', 'billing_info/show-200-username'
        )
      end

      it "exposes username as an attribute" do
        billing_info = BillingInfo.find 'venmo1234567890'
        billing_info.username.must_equal 'johnrambo'
      end
    end
  end


  describe 'verify' do
    it 'verifies billing info' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200'
      )
      stub_api_request(
        :post, 'accounts/abcdef1234567890/billing_info/verify', 'billing_info/verify-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      verified = billing_info.verify
      verified.must_be_instance_of Recurly::Transaction
      verified.origin.must_equal "api_verify_card"
    end

    it 'sends specified gateway code' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200'
      )
      stub_api_request(
        :post, 'accounts/abcdef1234567890/billing_info/verify', 'billing_info/verify-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      gateway = {gateway_code: "gateway_code"}
      verified = billing_info.verify(gateway)
      Recurly::Verify.to_xml(gateway).must_equal "<verify><gateway_code>gateway_code</gateway_code></verify>"
      verified.must_be_instance_of Recurly::Transaction
      verified.origin.must_equal "api_verify_card"
    end

    it 'only verifies credit cards' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200-bank-account'
      )
      stub_api_request(
        :post, 'accounts/abcdef1234567890/billing_info/verify', 'billing_info/verify-422'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      error = proc { billing_info.verify }.must_raise API::UnprocessableEntity
      error.message.must_equal 'Only stored credit card billing information can be verified at this time'
    end
  end

  describe 'verify_cvv' do
    it 'verifies the cvv' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/verify-cvv-200'
      )
      stub_api_request(
        :post, 'accounts/abcdef1234567890/billing_info/verify_cvv', 'billing_info/verify-cvv-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      attrs = { verification_value: 876 }
      verified = billing_info.verify_cvv(attrs)
      verified.must_be_instance_of Recurly::BillingInfo
    end

    it 'sends the verification value' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/verify-cvv-200'
      )
      stub_api_request(
        :post, 'accounts/abcdef1234567890/billing_info/verify_cvv', 'billing_info/verify-cvv-200'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      attrs = { verification_value: 876 }
      billing_info.verify_cvv(attrs)
      Recurly::BillingInfo.to_xml(attrs).must_equal "<billing_info><verification_value>876</verification_value></billing_info>"
    end
  end

  describe 'marshal methods' do
    it 'must return the same instance variables' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200-bank-account'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      billing_info_from_dump = Marshal.load(Marshal.dump(billing_info))

      billing_info.instance_variables.must_equal billing_info_from_dump.instance_variables
    end

    it 'must return the same values' do
      stub_api_request(
        :get, 'accounts/abcdef1234567890/billing_info', 'billing_info/show-200-bank-account'
      )
      billing_info = BillingInfo.find 'abcdef1234567890'
      billing_info_from_dump = Marshal.load(Marshal.dump(billing_info))

      billing_info.type.must_equal billing_info_from_dump.type
    end
  end
end
