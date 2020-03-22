require "spec_helper"

RSpec.describe Recurly::Client do
  subject(:client) { Recurly::Client.new(client_options) }
  let(:client_options) { { api_key: api_key } }
  let(:subdomain) { "test" }
  let(:api_key) { "recurly-good" }
  let(:resp_headers) do
    {
      "x-request-id" => "0av50sm5l2n2gkf88ehg",
      "x-ratelimit-limit" => "2000",
      "x-ratelimit-remaining" => "1985",
      "x-ratelimit-reset" => "1564624560",
      "date" => "Thu, 01 Aug 2019 01:26:44 GMT",
      "server" => "cloudflare",
      "cf-ray" => "4ff4b71268424738-EWR",
    }
  end
  let(:net_http) { Recurly::ConnectionPool.new.init_http_connection }
  let(:connection_pool) {
    pool = double("ConnectionPool")
    allow(pool).to receive(:with_connection).and_yield net_http
    pool
  }

  before {
    allow(client).to receive(:connection_pool).and_return connection_pool
  }

  context "#api_version" do
    it "should respond with a valid api version" do
      version_format = /v\d{4}-\d{2}-\d{2}/
      expect(version_format.match(client.api_version)).to be_instance_of(MatchData)
    end
  end

  context "with sucessful responses" do
    let(:response) do
      resp = Net::HTTPOK.new(1.0, "200", "OK")
      allow(resp).to receive(:body) do
        "{ \"object\": \"account\" }"
      end
      allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
      resp_headers.each { |key, v| resp[key] = v }
      resp
    end

    describe "headers" do
      it "should include the necessary headers in each request" do
        expected = hash_including("Accept" => /application\/vnd\.recurly/, "Content-Type" => "application/json", "User-Agent" => /Recurly\//)
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)

        expect(net_http).to receive(:request).and_return(response)
        _account = subject.get_account(account_id: "code-benjamin-du-monde")
      end
    end

    describe "#get" do
      it "should return an account object for get_account" do
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
        expect(net_http).to receive(:request).and_return(response)
        account = subject.get_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end

      it "should inject the response metatada" do
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
        expect(net_http).to receive(:request).and_return(response)
        account = subject.get_account(account_id: "code-benjamin-du-monde")
        expect(account.get_response).to be_instance_of Recurly::HTTP::Response
      end
    end

    describe "#delete" do
      it "should return a the deleted account for deactivate_account" do
        req = Recurly::HTTP::Request.new(:delete, "/accounts/code-benjamin-du-monde", nil)
        expect(net_http).to receive(:request).and_return(response)
        account = subject.deactivate_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "#put" do
      it "should return a the updated account for update_account" do
        body = { first_name: "Benjamin" }
        req = Recurly::HTTP::Request.new(:put, "/accounts/code-benjamin-du-monde", JSON.dump(body))
        expect(net_http).to receive(:request).and_return(response)
        account = subject.update_account(account_id: "code-benjamin-du-monde", body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "#post" do
      let(:response) do
        resp = Net::HTTPCreated.new(1.0, "201", "Created")
        allow(resp).to receive(:body) do
          "{ \"object\": \"account\" }"
        end
        allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
        resp_headers.each { |key, v| resp[key] = v }
        resp
      end

      it "should return a the created account for create_account" do
        body = { code: "benjamin-du-monde" }
        req = Recurly::HTTP::Request.new(:post, "/accounts", JSON.dump(body))
        expect(net_http).to receive(:request).and_return(response)
        account = subject.create_account(body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end

    describe "index calls" do
      let(:response) do
        resp = Net::HTTPOK.new(1.0, "200", "OK")
        allow(resp).to receive(:body) do
          <<-JSON
          {
            "object": "list",
            "has_more": false,
            "data": [{"object": "account", "id": "1"}, {"object": "account", "id": "2"}]
          }
          JSON
        end
        allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
        resp_headers.each { |key, v| resp[key] = v }
        resp
      end

      it "should return a pager of accounts from list_accounts" do
        req = Recurly::HTTP::Request.new(:get, "/accounts", nil)
        expect(net_http).to receive(:request).and_return(response)
        pager = subject.list_accounts
        expect(pager).to be_instance_of Recurly::Pager
        expect(pager.each).to all(be_a Recurly::Resources::Account)
      end
    end

    context "when passed an optional site_id" do
      describe "get" do
        it "should scope the url by site" do
          req = Recurly::HTTP::Request.new(:get, "/sites/subdomain-my-subdomain/accounts/code-benjamin-du-monde", nil)
          expect(net_http).to receive(:request).and_return(response)
          _account = subject.get_account(account_id: "code-benjamin-du-monde", site_id: "subdomain-my-subdomain")
        end
      end
    end

    context "when initialized with a site_id" do
      subject(:client) do
        Recurly::Client.new(
          api_key: api_key,
          subdomain: "my-subdomain",
        )
      end

      describe "get" do
        it "should scope the url by site" do
          req = Recurly::HTTP::Request.new(:get, "/sites/subdomain-my-subdomain/accounts/code-benjamin-du-monde", nil)
          expect(net_http).to receive(:request).and_return(response)
          _account = subject.get_account(account_id: "code-benjamin-du-monde")
        end
      end
    end

    describe "#log_level" do
      context "set to Logger::DEBUG" do
        let(:client_options) { { api_key: api_key, log_level: Logger::DEBUG } }

        it "sets the Net::HTTP logger" do
          expect(net_http).to receive(:set_debug_output).with(client.instance_variable_get(:@logger))
          expect(client.instance_variable_get(:@logger).level).to eql(Logger::DEBUG)

          expect(net_http).to receive(:request).and_return(response)
          subject.get_account(account_id: "code-benjamin-du-monde")
        end
      end

      context "defaults to Logger::WARN" do
        it "does not set the Net::HTTP logger" do
          expect(client.instance_variable_get(:@log_level)).to eql(Logger::WARN)
          expect(net_http).not_to receive(:set_debug_output)

          expect(net_http).to receive(:request).and_return(response)
          subject.get_account(account_id: "code-benjamin-du-monde")
        end
      end
    end
  end

  context "with unsucessful responses" do
    let(:response) do
      resp = Net::HTTPInternalServerError.new(1.0, "500", "Internal server error")
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
      allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
      resp_headers.each { |key, v| resp[key] = v }
      resp
    end

    describe "#get" do
      it "should raise an APIError" do
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
        expect(net_http).to receive(:request).and_return(response)
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::InternalServerError)
      end
    end
  end

  context "with network errors" do
    describe "#get" do
      it "should return an account object for get_account" do
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
        allow(net_http).to receive(:request).and_raise(Net::OpenTimeout, "Request timed out")
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::TimeoutError)
      end
    end
  end

  context "with bad url parameter arguments" do
    describe "#get" do
      it "should throw an ArgumentError" do
        expect {
          subject.get_account(account_id: Recurly::Resources::Account.new)
        }.to raise_error(ArgumentError)
      end
    end
  end

  context "with url param needing encoding" do
    let(:response) do
      resp = Net::HTTPOK.new(1.0, "200", "OK")
      allow(resp).to receive(:body) do
        "{ \"object\": \"account\" }"
      end
      allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
      resp_headers.each { |key, v| resp[key] = v }
      resp
    end

    describe "#get" do
      it "should return an account object for get_account even if code has spaces" do
        req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin%20du%20monde", nil)
        expect(net_http).to receive(:request).and_return(response)
        account = subject.get_account(account_id: "code-benjamin du monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end
  end

  describe "#extract_path returns the path and parameters" do
    let(:path) { "/accounts?cursor=xyz&limit=20&sort=created_at" }

    it "when given a path" do
      expect(client.send(:extract_path, path)).to eql(path)
    end

    it "when given a full URI" do
      expect(client.send(:extract_path, "https://v3.recurly.com#{path}")).to eql(path)
    end
  end
end
