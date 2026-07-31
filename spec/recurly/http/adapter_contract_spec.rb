require "spec_helper"
require_relative "../../support/mock_http_adapter"

RSpec.describe "HTTP adapter contract" do
  let(:api_key) { "recurly-good" }
  let(:ok_body) { "{ \"object\": \"account\" }" }
  let(:ok_response) { MockHttpAdapter.response(status_code: 200, body: ok_body) }
  let(:created_response) { MockHttpAdapter.response(status_code: 201, body: ok_body) }
  let(:adapter) { MockHttpAdapter.new(ok_response) }
  let(:client) { Recurly::Client.new(api_key: api_key, http_adapter: adapter) }

  # find the header the client handed the adapter, case-insensitively
  def header(call, name)
    key = call.headers.keys.find { |k| k.to_s.downcase == name.downcase }
    key && call.headers[key]
  end

  describe "what the client passes to the adapter" do
    it "passes the correct method and an ABSOLUTE url (scheme+host+path)" do
      client.get_account(account_id: "code-benjamin-du-monde")
      call = adapter.calls.last
      expect(call.method).to eq("GET")
      expect(call.url).to eq("https://v3.recurly.com/accounts/code-benjamin-du-monde")
    end

    it "includes the query string in the absolute url" do
      client.send(:get, "/accounts", params: { limit: 2 })
      call = adapter.calls.last
      expect(call.url).to start_with("https://v3.recurly.com/accounts?")
      expect(call.url).to include("limit=2")
    end

    it "passes app-level headers (Accept, Authorization, User-Agent)" do
      client.get_account(account_id: "code-benjamin-du-monde")
      call = adapter.calls.last
      expect(header(call, "Accept")).to match(%r{application/vnd\.recurly})
      expect(header(call, "Authorization")).to match(/Basic .*/)
      expect(header(call, "User-Agent")).to match(/^Recurly\//)
    end

    it "does NOT send transport headers (Host, Content-Length) — Net adds those later" do
      client.get_account(account_id: "code-benjamin-du-monde")
      call = adapter.calls.last
      downcased = call.headers.keys.map { |k| k.to_s.downcase }
      expect(downcased).not_to include("host")
      expect(downcased).not_to include("content-length")
    end

    context "GET / HEAD" do
      it "does NOT include an Idempotency-Key on GET" do
        client.get_account(account_id: "code-benjamin-du-monde")
        expect(header(adapter.calls.last, "Idempotency-Key")).to be_nil
      end

      it "does NOT include an Idempotency-Key on HEAD" do
        client.send(:head, "/accounts")
        expect(header(adapter.calls.last, "Idempotency-Key")).to be_nil
      end
    end

    context "POST / PUT (bodied verbs)" do
      let(:adapter) { MockHttpAdapter.new(created_response) }

      it "includes Content-Type: application/json and an Idempotency-Key, plus the JSON body" do
        client.create_account(body: { code: "benjamin-du-monde" })
        call = adapter.calls.last
        expect(call.method).to eq("POST")
        expect(header(call, "Content-Type")).to eq("application/json")
        expect(header(call, "Idempotency-Key")).not_to be_nil
        expect(call.body).to eq(JSON.dump({ code: "benjamin-du-monde" }))
      end

      it "includes Content-Type on PUT" do
        client.update_account(account_id: "code-benjamin-du-monde", body: { first_name: "Ben" })
        expect(header(adapter.calls.last, "Content-Type")).to eq("application/json")
      end
    end

    context "caller-supplied headers" do
      it "passes custom headers through" do
        client.get_account(account_id: "code-benjamin-du-monde", headers: { "Custom-Header" => "custom-value" })
        expect(header(adapter.calls.last, "Custom-Header")).to eq("custom-value")
      end

      it "a lowercase idempotency-key suppresses generation (no duplicate)" do
        adapter = MockHttpAdapter.new(created_response)
        client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)
        client.create_account(body: { code: "x" }, headers: { "idempotency-key" => "caller-key" })
        keys = adapter.calls.last.headers.keys.select { |k| k.to_s.downcase == "idempotency-key" }
        expect(keys.length).to eq(1)
        expect(header(adapter.calls.last, "Idempotency-Key")).to eq("caller-key")
      end

      it "a caller Content-Type overrides the SDK default" do
        adapter = MockHttpAdapter.new(created_response)
        client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)
        client.create_account(body: { code: "x" }, headers: { "content-type" => "application/json; charset=utf-8" })
        keys = adapter.calls.last.headers.keys.select { |k| k.to_s.downcase == "content-type" }
        expect(keys.length).to eq(1)
        expect(header(adapter.calls.last, "Content-Type")).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "per-request timeout overrides are forwarded across the seam" do
    it "passes options[:read_timeout]/[:open_timeout] to the adapter" do
      client.send(:get, "/accounts", read_timeout: 5, open_timeout: 2)
      call = adapter.calls.last
      expect(call.read_timeout).to eq(5)
      expect(call.open_timeout).to eq(2)
    end
  end

  describe "Idempotency-Key is stable across a transport retry" do
    it "re-issues with the SAME Idempotency-Key after a transport error" do
      transport = Recurly::Errors::TransportError.new("boom", kind: :connection)
      adapter = MockHttpAdapter.new([transport, created_response])
      client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)
      client.create_account(body: { code: "x" })
      keys = adapter.calls.map { |c| header(c, "Idempotency-Key") }
      expect(keys.length).to eq(2)
      expect(keys.uniq.length).to eq(1)
      expect(keys.first).not_to be_nil
    end
  end

  describe "gzip is optional (adapter may return an uncompressed body)" do
    it "handles a plain uncompressed JSON body" do
      account = client.get_account(account_id: "code-benjamin-du-monde")
      expect(account).to be_instance_of Recurly::Resources::Account
    end
  end

  describe "default adapter" do
    it "uses DefaultHttpAdapter when no adapter is provided" do
      default_client = Recurly::Client.new(api_key: api_key)
      expect(default_client.instance_variable_get(:@http_adapter)).to be_instance_of(Recurly::HTTP::DefaultHttpAdapter)
    end

    it "does not consult Client.connection_pool at request time when a custom adapter is injected" do
      client # build the client first (default-adapter construction touches the pool)
      expect(Recurly::Client).not_to receive(:connection_pool)
      client.get_account(account_id: "code-benjamin-du-monde")
    end
  end
end
