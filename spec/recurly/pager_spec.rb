require "spec_helper"
require 'date'

RSpec.describe Recurly::Pager do
  let(:subdomain) { 'test' }
  let(:api_key) { 'recurly-good' }
  let(:client) { Recurly::Client.new(api_key: api_key, subdomain: subdomain) }
  let(:path) { '/next_url' }
  let(:options) { {a: 1, b: DateTime.new(2020,1,1)} }
  subject do
    Recurly::Pager.new(client: client, path: path, options: options)
  end

  describe ".new" do
    it "should build next from path and options" do
      expect(subject.next).to eq("/next_url?a=1&b=2020-01-01T00%3A00%3A00%2B00%3A00")
    end
  end
end
