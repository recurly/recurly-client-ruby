require "spec_helper"

RSpec.describe Recurly::HTTP::DefaultHttpAdapter do
  let(:keep_alive_timeout) { 600 }
  let(:url) { "https://v3.recurly.com/accounts/code-benjamin-du-monde" }
  let(:net_http) do
    Recurly::ConnectionPool.new.init_http_connection(
      URI.parse(Recurly::Client::API_HOSTS[:us]), keep_alive_timeout, Recurly::Client::CA_FILE
    )
  end
  let(:connection_pool) do
    pool = double("ConnectionPool")
    allow(pool).to receive(:with_connection).and_yield(net_http)
    pool
  end
  subject(:adapter) do
    described_class.new(connection_pool: connection_pool, keep_alive_timeout: keep_alive_timeout, ca_file: Recurly::Client::CA_FILE)
  end

  def net_response(klass, code, message, body:, content_type: "application/json; charset=utf-8")
    resp = klass.new(1.0, code, message)
    allow(resp).to receive(:body).and_return(body)
    resp["content-type"] = content_type
    resp["x-request-id"] = "req-123"
    resp
  end

  describe "constructor default timeouts" do
    it "treats read_timeout: and open_timeout: as SECONDS, matching the per-request override unit" do
      adapter = described_class.new(
        connection_pool: connection_pool, keep_alive_timeout: keep_alive_timeout,
        ca_file: Recurly::Client::CA_FILE, read_timeout: 60, open_timeout: 20,
      )
      expect(adapter.instance_variable_get(:@read_timeout)).to eq(60)
      expect(adapter.instance_variable_get(:@open_timeout)).to eq(20)
    end
  end

  describe "security" do
    it "never enables the net_http debug output (would leak credentials/PII to STDOUT)" do
      resp = net_response(Net::HTTPOK, "200", "OK", body: "{}")
      expect(net_http).not_to receive(:set_debug_output)
      expect(net_http).to receive(:request).and_return(resp)
      adapter.call("GET", url, {}, nil)
    end
  end

  describe "successful responses" do
    it "returns a normalized AdapterResponse and does NOT raise" do
      resp = net_response(Net::HTTPOK, "200", "OK", body: "{}")
      expect(net_http).to receive(:request).and_return(resp)

      result = adapter.call("GET", url, {}, nil)
      expect(result).to be_instance_of(Recurly::HTTP::AdapterResponse)
      expect(result.status_code).to eq(200)
      expect(result.body).to eq("{}")
      expect(result["content-type"]).to eq("application/json; charset=utf-8")
      expect(result["X-Request-Id"]).to eq("req-123") # case-insensitive lookup
      expect(result.reason_phrase).to eq("OK")
    end
  end

  describe "malformed request url" do
    it "raises ArgumentError immediately, without attempting the request" do
      expect(net_http).not_to receive(:request)
      expect {
        adapter.call("GET", "https://v3.recurly.com/accounts/code foo", {}, nil)
      }.to raise_error(ArgumentError, /Invalid request URL/)
    end
  end

  describe "4xx / 5xx responses are RETURNED, not raised" do
    it "returns a 422 as a normalized response" do
      resp = net_response(Net::HTTPUnprocessableEntity, "422", "Unprocessable Entity", body: "{}")
      expect(net_http).to receive(:request).and_return(resp)
      result = adapter.call("POST", url, {}, "{}")
      expect(result.status_code).to eq(422)
    end

    it "returns a 502 as a normalized response (reason phrase preserved)" do
      resp = net_response(Net::HTTPBadGateway, "502", "Bad Gateway", body: "", content_type: "text/html")
      expect(net_http).to receive(:request).and_return(resp)
      result = adapter.call("GET", url, {}, nil)
      expect(result.status_code).to eq(502)
      expect(result.reason_phrase).to eq("Bad Gateway")
    end
  end

  describe "transport exceptions map to TransportError#kind" do
    def expect_kind(raised, kind)
      allow(net_http).to receive(:request).and_raise(raised)
      expect { adapter.call("GET", url, {}, nil) }.to raise_error(Recurly::Errors::TransportError) { |e| expect(e.kind).to eq(kind) }
    end

    it "Errno::ECONNREFUSED => :connection" do
      expect_kind(Errno::ECONNREFUSED, :connection)
    end

    it "Net::OpenTimeout => :timeout" do
      expect_kind(Net::OpenTimeout, :timeout)
    end

    it "Errno::ETIMEDOUT => :timeout" do
      expect_kind(Errno::ETIMEDOUT, :timeout)
    end

    it "Net::ReadTimeout => :timeout (via Timeout::Error, invariant A)" do
      # Net::ReadTimeout < Timeout::Error and is NOT in the Errno list.
      expect(Net::ReadTimeout.ancestors).to include(Timeout::Error)
      expect_kind(Net::ReadTimeout, :timeout)
    end

    it "OpenSSL::SSL::SSLError => :ssl" do
      expect_kind(OpenSSL::SSL::SSLError, :ssl)
    end

    it "a generic StandardError => :network" do
      expect_kind(StandardError, :network)
    end

    it "carries the underlying exception as #original_exception" do
      allow(net_http).to receive(:request).and_raise(Errno::ECONNREFUSED)
      expect { adapter.call("GET", url, {}, nil) }.to raise_error(Recurly::Errors::TransportError) { |e| expect(e.original_exception).to be_a(Errno::ECONNREFUSED) }
    end

    it "also carries the underlying exception as Ruby's built-in #cause (not shadowed)" do
      allow(net_http).to receive(:request).and_raise(Errno::ECONNREFUSED)
      expect { adapter.call("GET", url, {}, nil) }.to raise_error(Recurly::Errors::TransportError) { |e| expect(e.cause).to be_a(Errno::ECONNREFUSED) }
    end
  end
end
