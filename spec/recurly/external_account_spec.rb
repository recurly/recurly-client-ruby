require 'spec_helper'

describe ExternalAccount do
  let(:external_account) {
    ExternalAccount.new(
      account: Account.new(account_code: 'account_code'),
      id: 'sd28t3zdm59p',
      external_account_code: 'abc123',
      external_connection_type: 'GooglePlayStore',
      created_at: '2023-01-23T19:02:40Z',
      updated_at: '2023-02-23T19:02:40Z'
    )
  }

  let(:account) {
    stub_api_request :get, 'accounts/abcdef1234567890', 'accounts/show-200'
    Account.find 'abcdef1234567890'
  }

  describe "#associations" do
    it "has correct associations" do
      expect(external_account.account).must_be_instance_of Account
    end
  end

  describe "#methods" do
    it "has correct attributes" do
      expect(external_account.external_account_code).must_equal('abc123')
      expect(external_account.id).must_equal('sd28t3zdm59p')
      expect(external_account.external_connection_type).must_equal('GooglePlayStore')
      expect(external_account.created_at).must_equal('2023-01-23T19:02:40Z')
      expect(external_account.updated_at).must_equal('2023-02-23T19:02:40Z')
    end
  end

  describe ".index" do
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/accounts/abcdef1234567890/external_accounts",
        "accounts/external_accounts/index-200"
      )
    end

    it "returns an external account" do
      external_account = account.external_accounts[0]

      external_account.must_be_instance_of(ExternalAccount)
      external_account.id.must_equal('sd28t3zdm59p')
      external_account.external_account_code.must_equal('b115bda0-4259-45c9-8784-bea417724f84')
      external_account.external_connection_type.must_equal('GooglePlayStore')
      external_account.created_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 40))
      external_account.updated_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 47))
    end
  end

  describe ".find" do  
    before do
      stub_api_request(
        :get, "https://api.recurly.com/v2/accounts/abcdef1234567890/external_accounts/123",
        "accounts/external_accounts/show-200"
      )
    end

    it "returns an external account" do
      external_account = account.external_accounts.find('123')

      external_account.must_be_instance_of(ExternalAccount)
      external_account.id.must_equal('sd28t3zdm59p')
      external_account.external_account_code.must_equal('b115bda0-4259-45c9-8784-bea417724f84')
      external_account.external_connection_type.must_equal('GooglePlayStore')
      external_account.created_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 40))
      external_account.updated_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 47))
    end
  end
end
