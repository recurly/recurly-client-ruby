require "spec_helper"

describe InvoiceTemplate do
  let(:invoice_template) { Recurly::InvoiceTemplate.find('q0tzf7o7fpbl') }

  before do
    stub_api_request :get, 'invoice_templates/q0tzf7o7fpbl', 'invoice_templates/show-200'
    stub_api_request :get, 'invoice_templates/q0tzf7o7fpbl/accounts', 'invoice_templates/accounts/index-200'
  end

  describe ".find" do
    it "returns an invoice template when available" do
      invoice_template.must_be_instance_of(InvoiceTemplate)
      invoice_template.uuid.must_equal 'q0tzf7o7fpbl'
      invoice_template.name.must_equal 'Alternate Invoice Template'
      invoice_template.code.must_equal 'code1'
      invoice_template.description.must_equal 'Some Description'
    end
  end

  describe "#accounts" do
    it "returns invoice template accounts" do
      account = invoice_template.accounts[0]
      account.must_be_instance_of(Account)
      account.account_code.must_equal 'api100'
    end
  end
end
