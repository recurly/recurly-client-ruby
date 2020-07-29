require "spec_helper"
require "date"

RSpec.describe Recurly::Pager do
  let(:subdomain) { "test" }
  let(:api_key) { "recurly-good" }
  let(:client) { Recurly::Client.new(api_key: api_key, subdomain: subdomain) }
  let(:path) { "/next_url" }
  let(:options) { { params: { a: 1, b: "testing" } } }
  subject do
    Recurly::Pager.new(client: client, path: path, options: options)
  end

  describe "#requires_client?" do
    it "should always ask for the client to be injected" do
      expect(subject.requires_client?).to eq(true)
    end
  end

  describe "#first" do
    let(:options) { { params: { limit: 200, a: 1 } } }
    let(:first_response) do
      page = Recurly::Resources::Page.new
      page.data = [
        { "object" => "account", "id" => "1" },
      ]
      page.has_more = true
      page.next = "https://partner-api.recurly.com/next_url"
      page
    end
    it "should update the 'limit' param to 1" do
      expect(client).to receive(:get)
                          .with("/next_url", { params: { limit: 1, a: 1 } })
                          .and_return(first_response)
      subject.first
    end
  end

  describe "#count" do
    let(:head_response) do
      response = double("Recurly::HTTP::Response", :total_records => 1337)

      empty = Recurly::Resources::Empty.new
      empty.instance_variable_set(:@response, response)
      empty
    end

    it "#count" do
      expect(client).to receive(:head)
                          .with("/next_url", { params: { a: 1, b: "testing" } })
                          .and_return(head_response)
      expect(subject.count).to eq(1337)
    end
  end

  context "enumerators" do
    let(:more_response) do
      page = Recurly::Resources::Page.new
      page.data = [
        { "object" => "account", "id" => "1" },
        { "object" => "account", "id" => "2" },
        { "object" => "account", "id" => "3" },
      ]
      page.has_more = true
      page.next = "https://partner-api.recurly.com/next_url"
      page
    end
    let(:done_response) do
      page = Recurly::Resources::Page.new
      page.data = [
        { "object" => "account", "id" => "4" },
        { "object" => "account", "id" => "5" },
      ]
      page.has_more = false
      page.next = nil
      page
    end

    describe "#each_page" do
      it "should present an enumerator pages" do
        expect(client).to receive(:get).exactly(3).times
        allow(client).to receive(:get).and_return(more_response, more_response, done_response)
        subject.each_page do |page|
          expect(page).to be_an Array
          expect(page).to all(be_a Recurly::Resources::Account)
        end
      end
      it "should return an enumerator when not given a block" do
        expect(subject.each_page).to be_an Enumerator
      end
    end
    describe "#each" do
      it "should present an enumerator pages" do
        expect(client).to receive(:get).exactly(3).times
        allow(client).to receive(:get).and_return(more_response, more_response, done_response)
        subject.each do |item|
          expect(item).to be_a Recurly::Resources::Account
        end
      end
      it "should return an enumerator when not given a block" do
        expect(subject.each).to be_an Enumerator
      end

      it "#extract_path returns the path and parameters" do
        allow(client).to receive(:get).and_return(more_response, done_response)
        expect(client).to receive(:get).with("/next_url", anything)

        subject.each do |item|
          # NOOP
        end
      end
    end
  end
end
