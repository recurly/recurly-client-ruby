require "spec_helper"

# Opt-in integration test that makes ONE real read-only sandbox API call through
# a custom HTTP adapter, verifying a 2xx normalized response flows through the
# SDK end to end.
#
# Gated on RECURLY_INTEGRATION=1 AND a RECURLY_API_KEY so CI (which has neither)
# stays green — the example is skipped otherwise.
RSpec.describe "HTTP adapter integration (sandbox)", :integration do
  let(:api_key) { ENV["RECURLY_API_KEY"] }

  before do
    unless ENV["RECURLY_INTEGRATION"] == "1" && api_key && !api_key.empty?
      skip "set RECURLY_INTEGRATION=1 and RECURLY_API_KEY to run the live sandbox integration test"
    end
  end

  # A thin recording wrapper around the default adapter — proves a custom adapter
  # can sit in front of the real transport.
  class RecordingAdapter < Recurly::HTTP::Adapter
    attr_reader :calls

    def initialize(inner)
      @inner = inner
      @calls = []
    end

    def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
      @calls << [method, url]
      @inner.call(method, url, headers, body, open_timeout: open_timeout, read_timeout: read_timeout)
    end
  end

  it "performs a real sandbox call through a custom adapter and returns a parsed resource" do
    inner = Recurly::HTTP::DefaultHttpAdapter.new(
      connection_pool: Recurly::Client.connection_pool,
      keep_alive_timeout: 600,
      ca_file: Recurly::Client::CA_FILE,
    )
    adapter = RecordingAdapter.new(inner)
    client = Recurly::Client.new(api_key: api_key, http_adapter: adapter)

    # A read-only list call: returns a Pager; #first triggers the HTTP request.
    pager = client.list_accounts(limit: 1)
    first_page = pager.each.first # may be nil if the site has no accounts; the call still succeeds

    expect(adapter.calls.length).to be >= 1
    expect(adapter.calls.first.first).to eq("GET")
    # If any account exists it is a parsed resource; otherwise the empty page still flowed through 2xx.
    expect(first_page).to be_a(Recurly::Resources::Account) if first_page
  end
end
