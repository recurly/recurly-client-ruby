require "spec_helper"

RSpec.describe Recurly::Client do
  subject(:client) { Recurly::Client.new(**client_options) }
  let(:client_options) { { api_key: api_key, http_adapter: adapter } }
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
      "content-type" => "application/json; charset=utf-8",
    }
  end

  # Build a normalized AdapterResponse the way an adapter would return it.
  def adapter_response(status_code, message, body:, content_type: "application/json; charset=utf-8")
    headers = resp_headers.merge("content-type" => content_type)
    Recurly::HTTP::AdapterResponse.new(
      status_code: status_code,
      headers: headers,
      body: body,
      reason_phrase: message,
    )
  end

  let(:ok_body) { "{ \"object\": \"account\" }" }
  let(:response) { adapter_response(200, "OK", body: ok_body) }
  let(:adapter) { MockHttpAdapter.new(response) }

  context "#api_version" do
    it "should respond with a valid api version" do
      version_format = /v\d{4}-\d{2}-\d{2}/
      expect(version_format.match(client.api_version)).to be_instance_of(MatchData)
    end
  end

  context "#base_url" do
    it "should use US base url" do
      expect(client.instance_variable_get(:@base_uri).to_s).to eq(Recurly::Client::API_HOSTS[:us])
    end

    it "should use EU base url" do
      client = Recurly::Client.new(**client_options.merge(region: :eu))
      expect(client.instance_variable_get(:@base_uri).to_s).to eq(Recurly::Client::API_HOSTS[:eu])
    end

    describe "using a custom base url" do
      let(:custom_url) { "partner-api.recurly.com" }

      it "should use a custom base url in EU" do
        client = Recurly::Client.new(**client_options.merge(region: :eu, base_url: custom_url))
        expect(client.instance_variable_get(:@base_uri).to_s).to eq(custom_url)
      end

      it "should use a custom base url in US" do
        client = Recurly::Client.new(**client_options.merge(base_url: custom_url))
        expect(client.instance_variable_get(:@base_uri).to_s).to eq(custom_url)
      end

      it "should raise an ArgumentError when region is invalid" do
        expect {
          Recurly::Client.new(**client_options.merge(region: :none))
        }.to raise_error(ArgumentError, "Invalid region type. Expected one of: #{Recurly::Client::API_HOSTS.keys.join(", ")}")
      end
    end

    describe "using a custom keep alive timeout" do
      let(:keep_alive_timeout) { 10 }

      it "should use a custom base url in EU" do
        client = Recurly::Client.new(**client_options.merge(region: :eu, keep_alive_timeout: keep_alive_timeout))
        expect(client.instance_variable_get(:@keep_alive_timeout)).to eq(10)
      end

      it "should use a custom base url in US" do
        client = Recurly::Client.new(**client_options.merge(keep_alive_timeout: keep_alive_timeout))
        expect(client.instance_variable_get(:@keep_alive_timeout)).to eq(10)
      end
    end
  end

  context "with sucessful responses" do
    describe "headers" do
      it "should include the necessary headers in each request" do
        subject.get_account(account_id: "code-benjamin-du-monde")
        headers = adapter.calls.last.headers
        expect(headers["Accept"]).to match(%r{application/vnd\.recurly})
        expect(headers["Authorization"]).to match(/Basic .*/)
        expect(headers["User-Agent"]).to match(/^Recurly\/\d+(\.\d+){0,2}; ruby \d+(\.\d+){0,2}.*$/)
      end

      it "should include custom headers in each request" do
        headers = { "Custom-Header" => "custom-value" }
        subject.get_account(account_id: "code-benjamin-du-monde", headers: headers)
        expect(adapter.calls.last.headers["Custom-Header"]).to eq("custom-value")
      end
    end

    describe "#head" do
      let(:response) { adapter_response(200, "OK", body: "") }

      it "should return an Empty resource" do
        empty = subject.send(:head, "/accounts")
        expect(empty).to be_instance_of Recurly::Resources::Empty
        expect(adapter.calls.last.method).to eq("HEAD")
      end
    end

    describe "#get" do
      it "should return an account object for get_account" do
        account = subject.get_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
      end

      it "should inject the response metatada" do
        account = subject.get_account(account_id: "code-benjamin-du-monde")
        expect(account.get_response).to be_instance_of Recurly::HTTP::Response
        expect(account.get_response.request).to be_instance_of Recurly::HTTP::Request
      end

      it "hands the adapter a GET, an absolute url, and no body" do
        subject.get_account(account_id: "code-benjamin-du-monde")
        call = adapter.calls.last
        expect(call.method).to eq("GET")
        expect(call.url).to eq("https://v3.recurly.com/accounts/code-benjamin-du-monde")
        expect(call.body).to be_nil
      end
    end

    describe "#delete" do
      it "should return a the deleted account for deactivate_account" do
        account = subject.deactivate_account(account_id: "code-benjamin-du-monde")
        expect(account).to be_instance_of Recurly::Resources::Account
        expect(adapter.calls.last.method).to eq("DELETE")
      end
    end

    describe "#put" do
      it "should return a the updated account for update_account" do
        body = { first_name: "Benjamin" }
        account = subject.update_account(account_id: "code-benjamin-du-monde", body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
        call = adapter.calls.last
        expect(call.method).to eq("PUT")
        expect(call.body).to eq(JSON.dump(body))
      end
    end

    describe "#post" do
      let(:response) { adapter_response(201, "Created", body: ok_body) }

      it "should return a the created account for create_account" do
        body = { code: "benjamin-du-monde" }
        account = subject.create_account(body: body)
        expect(account).to be_instance_of Recurly::Resources::Account
        call = adapter.calls.last
        expect(call.method).to eq("POST")
        expect(call.body).to eq(JSON.dump(body))
      end

      it "should allow a nil request_data/class" do
        # Hacky way of ensuring that #post can be called without a body
        account = subject.send(:post, "/verify")
        expect(account).to be_instance_of Recurly::Resources::Account
        expect(adapter.calls.last.body).to be_nil
      end
    end

    describe "index calls" do
      let(:list_body) do
        <<-JSON
        {
          "object": "list",
          "has_more": false,
          "data": [{"object": "account", "id": "1"}, {"object": "account", "id": "2"}]
        }
        JSON
      end
      let(:response) { adapter_response(200, "OK", body: list_body) }

      it "should return a pager of accounts from list_accounts" do
        pager = subject.list_accounts
        expect(pager).to be_instance_of Recurly::Pager
        expect(pager.each).to all(be_a Recurly::Resources::Account)
      end
    end

    context "when passed an optional site_id" do
      describe "get" do
        it "should scope the url by site" do
          subject.get_account(account_id: "code-benjamin-du-monde", site_id: "subdomain-my-subdomain")
          expect(adapter.calls.last.url).to eq(
            "https://v3.recurly.com/sites/subdomain-my-subdomain/accounts/code-benjamin-du-monde"
          )
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
          subject.get_account(account_id: "code-benjamin-du-monde")
        end
      end
    end
  end

  context "with unsuccessful responses" do
    context "known errors" do
      let(:error_body) do
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
      let(:response) { adapter_response(500, "Internal Server Error", body: error_body) }

      describe "#get" do
        it "should raise an APIError" do
          expect {
            subject.get_account(account_id: "code-benjamin-du-monde")
          }.to raise_error(Recurly::Errors::InternalServerError)
          # 5xx GET => single inline re-issue: adapter is called exactly twice
          expect(adapter.calls.length).to eq(2)
        end
      end

      context "retries" do
        let(:successful_response) { adapter_response(200, "OK", body: ok_body) }
        let(:adapter) { MockHttpAdapter.new([response, successful_response]) }

        it "should retry and return success" do
          account = subject.get_account(account_id: "code-benjamin du monde")
          expect(account).to be_instance_of Recurly::Resources::Account
          expect(adapter.calls.length).to eq(2)
        end
      end

      context "the 5xx-GET re-issue never exceeds MAX_RETRIES" do
        let(:adapter) { MockHttpAdapter.new(response) }

        it "is called at most twice for a persistently-5xx GET" do
          expect {
            subject.get_account(account_id: "code-benjamin-du-monde")
          }.to raise_error(Recurly::Errors::InternalServerError)
          expect(adapter.calls.length).to eq(2)
        end
      end
    end

    context "unknown errors" do
      let(:account_id) { "1234" }
      let(:invoice_preview_path) { "/accounts/#{account_id}/invoices/preview" }
      describe "#post" do
        let(:error_body) do
          <<-JSON
          {
            "error": {
              "type": "unknown_error_type_code",
              "message": "An Unknown Error type code has been returned."
            }
          }
          JSON
        end
        let(:response) { adapter_response(409, "Conflict", body: error_body) }

        it "raises an APIError" do
          invoice_preview = { currency: "USD", collection_method: "automatic" }
          expect {
            subject.preview_invoice(account_id: account_id, body: invoice_preview)
          }.to raise_error(Recurly::Errors::APIError)
        end
      end
    end
  end

  context "with network errors (adapter raises TransportError)" do
    def transport(kind)
      Recurly::Errors::TransportError.new("boom", kind: kind)
    end

    it "Connection Refused => ConnectionFailedError" do
      client = Recurly::Client.new(api_key: api_key, http_adapter: MockHttpAdapter.new(transport(:connection)))
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::ConnectionFailedError)
    end

    it "Timeout (open/read) => TimeoutError" do
      client = Recurly::Client.new(api_key: api_key, http_adapter: MockHttpAdapter.new(transport(:timeout)))
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::TimeoutError)
    end

    it "SSL Issues => SSLError" do
      client = Recurly::Client.new(api_key: api_key, http_adapter: MockHttpAdapter.new(transport(:ssl)))
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::SSLError)
    end

    it "Unknown Error => NetworkError" do
      client = Recurly::Client.new(api_key: api_key, http_adapter: MockHttpAdapter.new(transport(:network)))
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::NetworkError)
    end

    it "retries transport errors up to MAX_RETRIES before raising" do
      adapter = MockHttpAdapter.new(transport(:connection))
      client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::ConnectionFailedError)
      # retries < MAX_RETRIES(3): calls at retries 0,1,2 => 3 total attempts
      expect(adapter.calls.length).to eq(3)
    end

    it "shares one retries counter across transport errors and the 5xx-GET re-issue (invariant B)" do
      # two connection errors bump retries to 2, then a 5xx arrives:
      # retries += 1 => 3, 3 < 3 false => no re-issue, the 5xx is returned/raised.
      err_500 = adapter_response(500, "Internal Server Error", body: <<-JSON)
        { "error": { "object": "error", "type": "internal_server_error", "message": "x" } }
      JSON
      adapter = MockHttpAdapter.new([transport(:connection), transport(:connection), err_500])
      client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)
      expect {
        client.get_account(account_id: "code-benjamin-du-monde")
      }.to raise_error(Recurly::Errors::InternalServerError)
      expect(adapter.calls.length).to eq(3)
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
    it "should return an account object for get_account even if code has spaces" do
      account = subject.get_account(account_id: "code-benjamin du monde")
      expect(account).to be_instance_of Recurly::Resources::Account
    end
  end

  context "with a missing api key" do
    describe "initialize" do
      let(:options) { { api_key: nil } }

      it "should raise an ArgumentError when api_key is nil" do
        expect {
          Recurly::Client.new(**options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "unexpected HTML responses" do
    context "with 200 OK" do
      let(:response) do
        adapter_response(200, "OK", body: "<html><body><h1>Unexpected HTML</h1></body></html>", content_type: "text/html; charset=utf-8")
      end

      it "should raise Recurly::Errors::InvalidContentTypeError" do
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::InvalidContentTypeError)
      end
    end

    context "with 503 Service Unavailable" do
      let(:response) do
        adapter_response(503, "Service Unavailable", body: "<html><body><h1>Service Unavailable</h1></body></html>", content_type: "text/html; charset=utf-8")
      end

      it "should raise Recurly::Errors::ServiceUnavailableError" do
        expect {
          subject.get_account(account_id: "code-benjamin-du-monde")
        }.to raise_error(Recurly::Errors::ServiceUnavailableError)
        # 5xx GET => single inline re-issue
        expect(adapter.calls.length).to eq(2)
      end
    end
  end
end
