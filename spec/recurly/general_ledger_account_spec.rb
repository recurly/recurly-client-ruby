require 'spec_helper'

describe GeneralLedgerAccount do
  let(:general_ledger_account) {
    stub_api_request(:get, "https://api.recurly.com/v2/general_ledger_accounts/u90r5deeaxix", "general_ledger_accounts/show-200")
    Recurly::GeneralLedgerAccount.find 'u90r5deeaxix'
  }

  let(:general_ledger_accounts) {
    stub_api_request(:get, "https://api.recurly.com/v2/general_ledger_accounts", "general_ledger_accounts/index-200")
    Recurly::GeneralLedgerAccount.all
  }

  describe "#find" do
    it "returns a GeneralLedgerAccount" do
      general_ledger_account.must_be_instance_of(GeneralLedgerAccount)
    end

    it "has correct attributes" do
      expect(general_ledger_account.id).must_equal('u90r5deeaxix')
      expect(general_ledger_account.code).must_equal('code1')
      expect(general_ledger_account.description).must_equal('string')
      expect(general_ledger_account.account_type).must_equal('revenue')
    end
  end

  describe "#index" do
    it "returns a list of general ledger accounts" do
      expect(general_ledger_accounts.count).must_equal(13)
    end
  end

  describe "#save" do
    let(:general_ledger_account) { GeneralLedgerAccount.new }
    it "must return true when new and valid" do
      stub_api_request :post, 'general_ledger_accounts', 'general_ledger_accounts/create-201'
      general_ledger_account.save.must_equal true
      general_ledger_account.code.must_equal 'code1'
    end
  end

  describe "#update" do
    it "sends changed attributes to the server" do
      stub_api_request :get, 'general_ledger_accounts/u90r5deeaxix', 'general_ledger_accounts/show-200'
      stub_request(:put, "https://api.recurly.com/v2/general_ledger_accounts/u90r5deeaxix").
      with(:body => "<general_ledger_account><description>new_string</description></general_ledger_account>",
        :headers => Recurly::API.headers).to_return(:status => 200, :body => "", :headers => {})
      general_ledger_account.update_attributes({ description: 'new_string' })
    end
  end
end
