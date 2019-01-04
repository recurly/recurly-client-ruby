require "spec_helper"

RSpec.describe Recurly::Client do
  let(:subdomain) { 'test' }
  let(:api_key) { 'recurly-good' }
  subject(:client) { Recurly::Client.new(api_key: api_key, subdomain: subdomain) }

  context "#api_version" do
    it "should respond with a valid api version" do
      version_format = /v\d{4}-\d{2}-\d{2}/
      expect(version_format.match(client.api_version)).to be_instance_of(MatchData)
    end
  end

  context "with sucessful responses" do
    let(:response) do
      resp = double()
      allow(resp).to receive(:body) do
        "{ \"object\": \"account\" }"
      end
      allow(resp).to receive(:status) do
        200
      end
      resp
    end

    describe "headers" do
      it "should include the necessary headers in each request" do
        expected = hash_including('Accept' => /application\/vnd\.recurly/, 'Content-Type' => 'application/json', 'User-Agent' => /Recurly\//)
        expect(client).to receive(:run_request).with(:get, "/sites/subdomain-test/accounts/code-benjamin-du-monde", nil, expected).and_return(response)
        _account = subject.get_account(account_id: "code-benjamin-du-monde")
      end
    end

    describe "#get" do
      it "should return an account object for get_account" do
        expect(client).to receive(:run_request).with(:get, "/sites/subdomain-test/accounts/code-benjamin-du-monde", nil, any_args).and_return(response)
        account = subject.get_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "#delete" do
      it "should return a the deleted account for deactivate_account" do
        expect(client).to receive(:run_request).with(:delete, "/sites/subdomain-test/accounts/code-benjamin-du-monde", nil, any_args).and_return(response)
        account = subject.deactivate_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "#put" do
      it "should return a the updated account for update_account" do
        body = { first_name: "Benjamin" }
        expect(client).to receive(:run_request).with(:put, "/sites/subdomain-test/accounts/code-benjamin-du-monde", JSON.dump(body), any_args).and_return(response)
        account = subject.update_account(account_id: "code-benjamin-du-monde", body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "#post" do
      let(:response) do
        resp = double()
        allow(resp).to receive(:body) do
          "{ \"object\": \"account\" }"
        end
        allow(resp).to receive(:status) do
          201
        end
        resp
      end

      it "should return a the created account for create_account" do
        body = { account_code: "benjamin-du-monde" }
        expect(client).to receive(:run_request).with(:post, "/sites/subdomain-test/accounts", JSON.dump(body), any_args).and_return(response)
        account = subject.create_account(body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "index calls" do
      let(:response) do
        resp = double()
        allow(resp).to receive(:body) do
          <<-JSON
          {
            "object": "list",
            "has_more": false,
            "data": [{"object": "account", "id": "1"}, {"object": "account", "id": "2"}]
          }
          JSON
        end
        allow(resp).to receive(:status) do
          200
        end
        resp
      end

      it "should return a pager of accounts from list_accounts" do
        expect(client).to receive(:run_request).with(:get, "/sites/subdomain-test/accounts", nil, any_args).and_return(response)
        pager = subject.list_accounts
        expect(pager).to be_instance_of Recurly::Pager
        expect(pager.each).to all(be_a Recurly::Resources::Account)
      end
    end
  end

  context "with unsucessful responses" do
    let(:response) do
      resp = double()
      allow(resp).to receive(:body) do
        <<-JSON
        {
          "error": {
            "object": "error",
            "type": "internal_server_error",
            "message": "Something happened"
          }
        }
        JSON
      end
      allow(resp).to receive(:status) do
        500
      end
      resp
    end

    describe "#get" do
      it "should raise an APIError" do
        expect(client).to receive(:run_request).with(:get, "/sites/subdomain-test/accounts/code-benjamin-du-monde", nil, any_args).and_return(response)
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::InternalServerError)
      end
    end
  end

  context "with network errors" do
    describe "#get" do
      it "should return an account object for get_account" do
        expect(client).to receive(:run_request).with(:get, "/sites/subdomain-test/accounts/code-benjamin-du-monde", nil, any_args).and_raise(Faraday::TimeoutError, "Request timed out")
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::TimeoutError)
      end
    end
  end
end
