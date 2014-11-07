require 'spec_helper'

describe Account do
  describe "instance methods" do
    let(:account) {
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      Account.find 'abcdef1234567890'
    }

    describe '#build_invoice' do
      it 'previews the accounts next invoice if successful' do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices/preview', 'invoices/preview-200'
        )
        account.build_invoice.must_be_instance_of Invoice
      end

      it 'raises an exception if unsuccessful' do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices/preview', 'invoices/create-422'
        )
        error = proc { account.build_invoice }.must_raise Resource::Invalid
        error.message.must_equal 'No charges to invoice'
      end
    end

    describe "#invoice!" do
      it "must invoice an account if successful" do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices', 'invoices/create-201'
        )
        account.invoice!.must_be_instance_of Invoice
      end

      it "must add optional attributes to the invoice if given" do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices', 'invoices/create-with-optionals-201'
        )
        invoice = account.invoice!({
          terms_and_conditions: 'Some Terms and Conditions',
          customer_notes: 'Some Customer Notes'
        })

        invoice.must_be_instance_of Invoice
        invoice.customer_notes.must_equal 'Some Customer Notes'
        invoice.terms_and_conditions.must_equal 'Some Terms and Conditions'
      end

      it "must raise an exception if unsuccessful" do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices', 'invoices/create-422'
        )
        error = proc { account.invoice! }.must_raise Resource::Invalid
        error.message.must_equal 'No charges to invoice'
      end
    end
  end

  describe ".find" do
    it "must return an account when available" do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      account = Account.find 'abcdef1234567890'
      account.must_be_instance_of Account
      account.account_code.must_equal 'abcdef1234567890'
      account.username.must_equal 'shmohawk58'
      account.email.must_equal 'larry.david@example.com'
      account.first_name.must_equal 'Larry'
      account.last_name.must_equal 'David'
      account.accept_language.must_equal 'en-US'
      account.entity_use_code.must_equal 'I'
      account.vat_number.must_equal '12345-67'
      account.address.address1.must_equal '123 Main St.'
      account.address.city.must_equal 'San Francisco'
      account.address.state.must_equal 'CA'
      account.address.zip.must_equal '94105'
      account.address.phone.must_equal '8015551234'
      account.address.country.must_equal 'US'
    end

    it 'must return an account with tax state' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200-taxed'
      account = Account.find 'abcdef1234567890'
      account.tax_exempt?.must_equal true
    end

    it "must raise an exception when unavailable" do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-404'
      proc { Account.find 'abcdef1234567890' }.must_raise Resource::NotFound
    end
  end

  describe ".paginate" do
    it "must return a pager" do
      stub_api_request :get, 'accounts', 'accounts/index-200'
      pager = Account.paginate
      pager.must_be_instance_of Resource::Pager
    end
  end

  describe "#save" do
    before do
      @account = Account.new :account_code => 'code'
    end

    it "must return true when new and valid" do
      stub_api_request :post, 'accounts', 'accounts/create-201'
      @account.save.must_equal true
    end

    it "must return false when new and invalid" do
      stub_api_request :post, 'accounts', 'accounts/create-422'
      @account.save.must_equal false
      @account.errors[:email].wont_be_nil
    end

    it "must embed provided billing info" do
      @account.billing_info = { :credit_card_number => 4111111111111111 }
      @account.to_xml.must_equal <<XML.chomp
<account>\
<account_code>code</account_code>\
<billing_info>\
<credit_card_number>4111111111111111</credit_card_number>\
</billing_info>\
</account>
XML
    end

    it "must embed provided billing info with a token" do
      @account.billing_info = { token_id: 'abc123' }
      @account.to_xml.must_equal <<XML.chomp
<account>\
<account_code>code</account_code>\
<billing_info>\
<token_id>abc123</token_id>\
</billing_info>\
</account>
XML
    end

    describe "persisted accounts" do
      before do
        @account.persist!
        @account.username = "heisenberg"
      end

      it "must return true when updating and valid" do
        stub_api_request :put, 'accounts/code', 'accounts/update-200'
        @account.save.must_equal true
      end

      it "must return false when updating and invalid" do
        stub_api_request :put, 'accounts/code', 'accounts/update-422'
        @account.save.must_equal false
        @account.errors[:email].wont_be_nil
      end
    end
  end

  describe 'serialize address to xml' do
    it "must serialize" do
      account = Account.new :account_code => 'code'
      account.vat_number = '12345-67'
      address = Address.new
      address.address1 = "123 Main Street"
      address.address2 = "Suite 190"
      address.city = "SF"
      address.state = "CA"
      address.zip = "93857"
      account.address = address
      account.to_xml.must_equal get_raw_xml("accounts/address-serialized.xml")
    end
  end

  describe "#to_xml" do
    it "must serialize" do
      account = Account.new :username => 'importantbreakfast'
      account.to_xml.must_equal(
        '<account><username>importantbreakfast</username></account>'
      )
    end
  end

  describe "associations" do
    let(:account) {
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      stub_api_request :get, 'accounts/abcdef1234567890/subscriptions', 'accounts/subscriptions/index-200'
      Account.find 'abcdef1234567890'
    }

    it "retrieves associations" do
      account.subscriptions.first.must_be_instance_of Subscription
    end

    describe "when an account_code contains spaces" do
      let(:account) {
        stub_api_request :get, 'accounts/my%20account', 'accounts/show-200-space'
        stub_api_request :get, 'accounts/my%20account/subscriptions', 'accounts/subscriptions/index-200-space'
        Account.find 'my account'
      }
      it "retrieves associations" do
        account.subscriptions.first.must_be_instance_of Subscription
      end
    end
  end
end
