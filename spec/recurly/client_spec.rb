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
end
