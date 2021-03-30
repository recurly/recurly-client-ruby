require "spec_helper"

RSpec.describe Recurly::Client do
  subject(:client) { Recurly::Client.new(**client_options) }
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
      "recurly-total-records" => "3804",
    }
  end
  let(:net_http) { Recurly::ConnectionPool.new.init_http_connection }
  let(:connection_pool) {
    pool = double("ConnectionPool")
    allow(pool).to receive(:with_connection).and_yield net_http
    pool
  }

  before {
    allow(client.class).to receive(:connection_pool).and_return connection_pool
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
      let(:request) do
        req_dbl = instance_double(Net::HTTP::Get)
        expect(req_dbl).to receive(:[]=).with("Accept", /application\/vnd\.recurly/)
        expect(req_dbl).to receive(:[]=).with("Authorization", /Basic .*/)
        expect(req_dbl).to receive(:[]=).with("User-Agent", /^Recurly\/\d+(\.\d+){0,2}; ruby \d+(\.\d+){0,2}.*$/)
        expect(req_dbl).to receive(:[]=).with("Idempotency-Key", anything)
        allow(req_dbl).to receive(:[])
        allow(req_dbl).to receive(:body).and_return("")
        allow(req_dbl).to receive(:method).and_return("GET")
        allow(req_dbl).to receive(:path).and_return("/accounts/code-benjamin-du-monde")

        req_dbl
      end

      it "should include the necessary headers in each request" do
        allow(Net::HTTP::Get).to receive(:new).and_return(request)

        expect(net_http).to receive(:request).and_return(response)
        _account = subject.get_account(account_id: "code-benjamin-du-monde")
      end

      it "should include custom headers in each request" do
        expect(request).to receive(:[]=).with("Custom-Header", "custom-value")
        allow(Net::HTTP::Get).to receive(:new).and_return(request)

        expect(net_http).to receive(:request).and_return(response)
        headers = { "Custom-Header" => "custom-value" }
        _account = subject.get_account(account_id: "code-benjamin-du-monde", headers: headers)
      end
    end

    describe "#head" do
      let(:response) do
        resp = Net::HTTPOK.new(1.0, "200", "OK")
        allow(resp).to receive(:body) { "" }
        resp_headers.each { |key, v| resp[key] = v }
        resp
      end

      it "should return an Empty resource" do
        expect(net_http).to receive(:request).and_return(response)
        empty = subject.send(:head, "/accounts")
        expect(empty).to be_instance_of Recurly::Resources::Empty
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
        expect(account.get_response.request).to be_instance_of Recurly::HTTP::Request
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

    context "logging" do
      describe "initialize" do
        context "with a valid logger" do
          let(:options) do
            {
              api_key: api_key,
              logger: Logger.new(STDOUT).tap { |l| l.level = Logger::WARN },
            }
          end

          it "should allow a valid Logger to be passed in" do
            expect {
              Recurly::Client.new(**options)
            }.not_to raise_error
          end
        end

        context "with a debug logger" do
          let(:logger) do
            Logger.new(STDOUT).tap { |l| l.level = Logger::DEBUG }
          end
          let(:options) do
            {
              api_key: api_key,
              logger: logger,
            }
          end

          it "should allow but warn the programmer" do
            expect(logger).to receive(:warn)
            expect {
              Recurly::Client.new(**options)
            }.not_to raise_error
          end
        end

        context "with a invalid logger" do
          let(:options) do
            {
              api_key: api_key,
              logger: {}, # some random object
            }
          end

          it "should allow a valid Logger to be passed in" do
            expect {
              Recurly::Client.new(**options)
            }.to raise_error(ArgumentError)
          end
        end
      end

      describe "log level" do
        it "defaults to WARN" do
          expect(client.instance_variable_get(:@logger).level).to eql(Logger::WARN)

          expect(net_http).to receive(:request).and_return(response)
          subject.get_account(account_id: "code-benjamin-du-monde")
        end

        # It should never enable net http debug as that is dangerous
        it "never enables the net_http debug output" do
          expect(net_http).not_to receive(:set_debug_output)
          expect(net_http).to receive(:request).and_return(response)
          subject.get_account(account_id: "code-benjamin-du-monde")
        end
      end
    end
  end

  context "with unsuccessful responses" do
    context "known errors" do
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
          expect(net_http).to receive(:request).twice.and_return(response)
          expect {
            subject.get_account(account_id: "code-benjamin-du-monde")
          }.to raise_error(Recurly::Errors::InternalServerError)
        end
      end

      context "retries" do
        let(:successful_response) do
          resp = Net::HTTPOK.new(1.0, "200", "OK")
          allow(resp).to receive(:body) do
            "{ \"object\": \"account\" }"
          end
          allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
          resp_headers.each { |key, v| resp[key] = v }
          resp
        end

        it "should retry and return success" do
          expect(net_http).to receive(:request).and_return(response)
          expect(net_http).to receive(:request).and_return(successful_response)
          account = subject.get_account(account_id: "code-benjamin du monde")
          expect(account).to be_instance_of Recurly::Resources::Account
        end
      end
    end

    context "unknown errors" do
      let(:account_id) { "1234" }
      let(:invoice_preview_path) { "/accounts/#{account_id}/invoices/preview" }
      describe "#post" do
        let(:response) do
          resp = Net::HTTPConflict.new(1.0, "0", "Conflict")
          allow(resp).to receive(:body) do
            <<-JSON
            {
              "error": {
                "type": "unknown_error_type_code",
                "message": "An Unknown Error type code has been returned."
              }
            }
            JSON
          end
          allow(resp).to receive(:content_type).and_return "application/json; charset=utf-8"
          resp_headers.each { |key, v| resp[key] = v }
          resp
        end

        it "raises an APIError" do
          invoice_preview = { currency: "USD", collection_method: "automatic" }
          Recurly::HTTP::Request.new(:post, invoice_preview_path, JSON.dump(invoice_preview))
          expect(net_http).to receive(:request).and_return(response)

          expect {
            subject.preview_invoice(account_id: account_id, body: invoice_preview)
          }.to raise_error(Recurly::Errors::APIError)
        end
      end
    end
  end

  context "with network errors" do
    it "Connection Refused" do
      req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
      allow(net_http).to receive(:request).and_raise(Errno::ECONNREFUSED, "Connection Refused")
      expect {
        subject.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::ConnectionFailedError)
    end

    it "Open Timeout" do
      req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
      allow(net_http).to receive(:request).and_raise(Net::OpenTimeout, "Request timed out")
      expect {
        subject.get_account(account_id: "code-benjamin-du-monde")
        # A retry should occur
      }.to raise_error(Recurly::Errors::TimeoutError)
    end

    it "Read Timeout" do
      req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
      allow(net_http).to receive(:request).and_raise(Net::ReadTimeout, "Request timed out")
      expect {
        subject.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::TimeoutError)
    end

    it "SSL Issues" do
      req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
      allow(net_http).to receive(:request).and_raise(OpenSSL::SSL::SSLError, "SSL Error")
      expect {
        subject.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::SSLError)
    end

    it "Unknown Error" do
      req = Recurly::HTTP::Request.new(:get, "/accounts/code-benjamin-du-monde", nil)
      allow(net_http).to receive(:request).and_raise(StandardError, "Generic Error")
      expect {
        subject.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::NetworkError)
    end
  end

  context "with bad url parameter arguments" do
    describe "#get" do
      it "should throw an ArgumentError with non-primitive arguments" do
        expect {
          subject.get_account(account_id: Recurly::Resources::Account.new)
        }.to raise_error(ArgumentError)
      end

      it "should throw an ArgumentError with nil arguments" do
        expect { subject.get_account(account_id: nil) }.to raise_error(ArgumentError)
      end

      it "should throw an ArgumentError with empty arguments" do
        expect { subject.get_account(account_id: "") }.to raise_error(ArgumentError)
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
        expect(net_http).to receive(:request).and_return(response)
        account = subject.get_account(account_id: "code-benjamin du monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end
    end
  end

  describe "unexpected HTML responses" do
    context "with 200 OK" do
      let(:response) do
        resp = Net::HTTPOK.new(1.0, "200", "OK")
        allow(resp).to receive(:body) do
          "<html><body><h1>Unexpected HTML</h1></body></html>"
        end
        allow(resp).to receive(:content_type).and_return "text/html; charset=utf-8"
        resp_headers.each { |key, v| resp[key] = v }
        resp
      end

      it "should raise Recurly::Errors::InvalidContentTypeError" do
        expect(net_http).to receive(:request).and_return(response)
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::InvalidContentTypeError)
      end
    end

    context "with 503 Service Unavailable" do
      let(:response) do
        resp = Net::HTTPServiceUnavailable.new(1.0, "503", "Service Unavailable")
        allow(resp).to receive(:body) do
          "<html><body><h1>Service Unavailable</h1></body></html>"
        end
        allow(resp).to receive(:content_type).and_return "text/html; charset=utf-8"
        resp_headers.each { |key, v| resp[key] = v }
        resp
      end

      it "should raise Recurly::Errors::ServiceUnavailableError" do
        expect(net_http).to receive(:request).twice.and_return(response)
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::ServiceUnavailableError)
      end
    end
  end
end
