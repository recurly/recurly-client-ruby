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
        collection = account.build_invoice
        collection.must_be_instance_of InvoiceCollection
        collection.charge_invoice.must_be_instance_of Invoice
      end

      it 'derives and parses the account from the invoice preview' do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices/preview', 'invoices/preview-200'
        )
        collection = account.build_invoice
        collection.charge_invoice.address.must_be_instance_of Address
        collection.charge_invoice.address.country.must_equal 'US'
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
        collection = account.invoice!
        collection.must_be_instance_of InvoiceCollection
        collection.charge_invoice.must_be_instance_of Invoice
      end

      it "must add optional attributes to the invoice if given" do
        stub_api_request(
          :post, 'accounts/abcdef1234567890/invoices', 'invoices/create-with-optionals-201'
        )
        collection = account.invoice!({
          terms_and_conditions: 'Some Terms and Conditions',
          customer_notes: 'Some Customer Notes'
        })

        invoice = collection.charge_invoice
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

    describe "#shipping_addresses" do
      it "must return shipping addresses" do
        stub_api_request(
          :get,
          'accounts/abcdef1234567890/shipping_addresses',
          'shipping_addresses/index-200'
        )

        shads = account.shipping_addresses.all
        shads.length.must_equal 1
        shads.first.must_be_instance_of Recurly::ShippingAddress
      end
    end
  end

  describe ".find" do
    it "must return an account when available" do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      account = Account.find 'abcdef1234567890'
      account.must_be_instance_of Account
      account.credit_payments.must_be_instance_of Resource::Pager
      account.account_code.must_equal 'abcdef1234567890'
      account.username.must_equal 'shmohawk58'
      account.email.must_equal 'larry.david@example.com'
      account.cc_emails.must_equal 'cheryl.hines@example.com,richard.lewis@example.com'
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
      account.vat_location_valid.must_equal true
      account.has_live_subscription.must_equal true
      account.has_active_subscription.must_equal true
      account.has_future_subscription.must_equal false
      account.has_past_due_invoice.must_equal false
      account.preferred_locale.must_equal 'fr-FR'
    end

    it 'must return an account with tax state' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200-taxed'
      account = Account.find 'abcdef1234567890'
      account.tax_exempt?.must_equal true
    end

    it 'must return an account with exemption certificate' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200-taxed'
      account = Account.find 'abcdef1234567890'
      account.exemption_certificate.must_equal 'Some Certificate'
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

  describe "#changed_attributes" do
    let(:account) do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      Account.find 'abcdef1234567890'
    end

    it "should be dirty if address was modified" do
      account.address.address1 = "1600 Pennsylvania Ave."
      account.changed?.must_equal true
    end

    it "should be clean if address was not modified" do
      account.changed?.must_equal false
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

  describe "#verify_cvv!" do
    let(:account) {
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      Account.find('abcdef1234567890')
    }

    it "should call endpoint and set new billing info details" do
      stub_api_request :post, 'accounts/abcdef1234567890/billing_info/verify_cvv', 'billing_info/verify-cvv-200'
      bi = account.verify_cvv! "504"
      bi.first_name.must_equal "Good"
      bi.last_name.must_equal  "CVV"
    end

    it "should raise BadRequest when checking too many times and cvv locked" do
      stub_api_request :post, 'accounts/abcdef1234567890/billing_info/verify_cvv', 'billing_info/verify-cvv-locked-400'
      error = proc { account.verify_cvv! "504" }.must_raise API::BadRequest
      error.message.must_equal "This credit card has too many cvv check attempts."
    end

    it "should raise Transaction::Error when payment gateway declines cvv" do
      stub_api_request :post, 'accounts/abcdef1234567890/billing_info/verify_cvv', 'billing_info/verify-cvv-transaction-err-422'
      error = proc { account.verify_cvv! "504" }.must_raise Transaction::DeclinedError
      error.transaction_error_code.must_equal "fraud_security_code"
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

    describe "when account has a balance" do
      let(:account) {
        stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
        stub_api_request :get, 'accounts/abcdef1234567890/balance', 'account_balance/show-200'
        Account.find 'abcdef1234567890'
      }

      it "is able to retrieve and parse account balance" do
        account_balance = account.account_balance
        account_balance.past_due.must_equal true
        balance = account_balance.balance_in_cents
        balance[:USD].must_equal(2910)
        balance[:EUR].must_equal(-520)
      end
    end

    describe "when account has notes" do
      let(:account) {
        stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
        stub_api_request :get, 'accounts/abcdef1234567890/notes', 'accounts/notes/show-200'
        Account.find 'abcdef1234567890'
      }

      it "is able to retrieve and parse notes" do
        notes = account.notes
        note = notes.first
        note.must_be_instance_of Note
        note.message.must_equal 'This is a very important note'
      end
    end

    describe "when account has an invoice template" do
      let(:account) {
        stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
        stub_api_request :get, 'invoice_templates/q0tzf7o7fpbl', 'invoice_templates/show-200'
        Account.find 'abcdef1234567890'
      }

      it "is able to retrieve and parse invoice template" do
        invoice_template = account.invoice_template
        invoice_template.must_be_instance_of InvoiceTemplate
        invoice_template.uuid.must_equal 'q0tzf7o7fpbl'
        invoice_template.name.must_equal 'Alternate Invoice Template'
        invoice_template.code.must_equal 'code1'
        invoice_template.description.must_equal 'Some Description'
      end
    end
  end

  describe 'custom fields' do
    let(:account) {
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      Account.find 'abcdef1234567890'
    }

    it 'should have a custom field' do
      account.custom_fields.must_equal [CustomField.new(name: 'acct_field', value: 'acct value')]
    end
  end

  describe "dunning_campaign_id" do
    let(:account) {
      stub_api_request :get, "accounts/abcdef1234567890", "accounts/show-200"
      Account.find("abcdef1234567890")
    }

    it "should have a dunning_campaign_id" do
      account.dunning_campaign_id.must_equal("1234abcd")
    end
  end

  describe "#company" do
    it "should respond to company_name even if the xml gives you company" do
      account = Account.from_xml "<account><company>My Company Inc.</company></account>"
      account.company_name.must_equal "My Company Inc."
      account.company.must_equal "My Company Inc."
    end

    it 'should respond to company_name when company is not included in xml response' do
      account = Account.from_xml '<account><company_name>My Company Inc.</company_name></account>'
      account.company_name.must_equal 'My Company Inc.'
    end
  end

  describe "account acquisition" do
    let(:account) {
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      stub_api_request :get, 'accounts/abcdef1234567890/acquisition', 'account_acquisition/show-200'
      Account.find 'abcdef1234567890'
    }

    it 'is able to retrieve and parse acquisition' do
      acquisition = account.account_acquisition
      acquisition.cost_in_cents.must_equal 299
      acquisition.channel.must_equal "blog"
      acquisition.campaign.must_equal "mailchimp67a904de95.0914d8f4b4"
    end
  end

  describe 'account hierarchy' do
    it 'should associate parent account on child creation' do
      stub_api_request :post, 'accounts', 'accounts/hierarchy/create-201'
      stub_api_request :get, 'accounts/1234567890', 'accounts/hierarchy/show-parent-200'
      account = Account.create(
        :account_code => 'abcdef1234567890',
        :parent_account_code => '1234567890'
      )
      account.parent_account.must_be_instance_of Account
      account.parent_account.account_code.must_equal '1234567890'
    end

    it 'should add parent account via update' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
      stub_api_request :put, 'accounts/abcdef1234567890', 'accounts/hierarchy/update-200'
      stub_api_request :get, 'accounts/1234567890', 'accounts/hierarchy/show-parent-200'

      account = Account.find 'abcdef1234567890'
      account.parent_account_code = '1234567890'
      account.save!

      account.parent_account.must_be_instance_of Account
      account.parent_account.account_code.must_equal '1234567890'
    end

    it 'should remove parent account via update' do
      stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/hierarchy/show-child-200'
      stub_api_request :put, 'accounts/abcdef1234567890', 'accounts/hierarchy/update-no-parent-200'

      account = Account.find 'abcdef1234567890'
      account.parent_account_code = ''
      account.save!

      account.parent_account.must_be_nil
    end

    it 'should list child accounts' do
      stub_api_request :get, 'accounts/1234567890', 'accounts/hierarchy/show-parent-200'
      stub_api_request :get, 'accounts/1234567890/child_accounts', 'accounts/hierarchy/show-children-200'

      account = Account.find '1234567890'
      account.child_accounts.must_be_instance_of Resource::Pager
      account.child_accounts.first.must_be_instance_of Account
      account.child_accounts.first.account_code.must_equal 'abcdef1234567890'
    end
  end
end
