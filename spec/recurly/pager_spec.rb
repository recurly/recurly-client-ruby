require "spec_helper"
require "date"

RSpec.describe Recurly::Pager do
  let(:subdomain) { "test" }
  let(:api_key) { "recurly-good" }
  let(:client) { Recurly::Client.new(api_key: api_key, subdomain: subdomain) }
  let(:path) { "/next_url" }
  let(:options) { { a: 1, b: DateTime.new(2020, 1, 1) } }
  subject do
    Recurly::Pager.new(client: client, path: path, options: options)
  end

  describe ".new" do
    it "should build next from path and options" do
      expect(subject.next).to eq("/next_url?a=1&b=2020-01-01T00%3A00%3A00%2B00%3A00")
    end
  end

  describe "#requires_client?" do
    it "should always ask for the client to be injected" do
      expect(subject.requires_client?).to eq(true)
    end
  end

  describe "#first" do
    let(:options) { { limit: 200, a: 1 } }
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
      expect(client).to receive(:next_page)
                          .with("/next_url?limit=1&a=1")
                          .and_return(first_response)
      subject.first
    end
  end

  it "#count" do
    expect(client).to receive(:get_resource_count)
                        .with("/next_url?a=1&b=2020-01-01T00%3A00%3A00%2B00%3A00")
    subject.count
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
        expect(client).to receive(:next_page).exactly(3).times
        allow(client).to receive(:next_page).and_return(more_response)
        page_num = 0
        subject.each_page do |page|
          page_num += 1
          if page_num == 2
            # on the 3rd call let's return the done_response
            allow(client).to receive(:next_page).and_return(done_response)
          end
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
        expect(client).to receive(:next_page).exactly(3).times
        allow(client).to receive(:next_page).and_return(more_response)
        item_num = 0
        subject.each do |item|
          item_num += 1
          if item_num >= 6
            # on the 3rd call (2 items per page) let's return the done_response
            allow(client).to receive(:next_page).and_return(done_response)
          end
          expect(item).to be_a Recurly::Resources::Account
        end
      end
      it "should return an enumerator when not given a block" do
        expect(subject.each).to be_an Enumerator
      end
    end
  end
end
