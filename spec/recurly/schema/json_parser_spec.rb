require "spec_helper"

RSpec.describe Recurly::JSONParser do
  let(:json_data) { '{"object": "my_resource", "a_string": "A String"}' }
  let(:client) {
    Recurly::Client.new(subdomain: 'test', api_key: 'test123')
  }

  describe ".parse" do
    subject { described_class.parse(client, json_data) }

    context "when the resource does not need a client" do
      let(:resource) { Recurly::Resources::MyResource.new(a_string: "A String") }
      it { is_expected.to eq(resource) }
    end
    context "when the resource needs a client" do
      let(:resource) { Recurly::Resources::MyResourceWithClient.new(a_string: "A String") }
      let(:json_data) { '{"object": "my_resource_with_client", "a_string": "A String"}' }
      it { is_expected.to eq(resource) }
      it "should set the client" do
        expect(subject.client).to eq(client)
      end
    end
    context "when the resource is an error" do
      let(:resource) { Recurly::Resources::Error.new(message: 'A String') }
      let(:json_data) { '{"error": {"message": "A String"}}' }
      it { is_expected.to eq(resource) }
    end
    context "when the class can't be found" do
      let(:json_data) { '{"object": "unknown"}' }
      it "should raise an ArgumentError" do
        expect{subject}.to raise_error(ArgumentError)
      end
    end
  end

  describe ".recurly_class" do
    subject { described_class.recurly_class(type) }
    context "when type is nil" do
      let(:type) { nil }
      it { is_expected.to eq nil }
    end
    context "when type is list" do
      let(:type) { 'list' }
      it { is_expected.to eq Recurly::Pager }
    end
    context "when type is known class type" do
      let(:type) { 'my_resource' }
      it { is_expected.to eq Recurly::Resources::MyResource }
    end
    context "when type is unknown class type" do
      let(:type) { 'unknown' }
      it { is_expected.to eq nil }
    end
  end
end
