require 'spec_helper'

describe Usage do
  before do
    stub_api_request :get, 'subscriptions/abcdef1234567890', 'subscriptions/show-200'
    stub_api_request(
      :post,
      'subscriptions/abcdef1234567890/add_ons/marketing_email/usage',
      'subscriptions/add_ons/usage/create-201'
    )
  end

  let(:subscription) { Subscription.find 'abcdef1234567890' }

  let(:subscription_add_on) do
    # Select your add on by the code you want
    subscription.subscription_add_ons.detect do |add_on|
      add_on.add_on_code == 'marketing_email'
    end
  end

  let(:usage) do
    subscription_add_on.usage.build
  end

  describe "pager" do
    let(:pager) { subscription_add_on.usage }

    it "must correctly build the pager for the usage endpoint" do
      pager.uri.must_equal "https://api.recurly.com/v2/subscriptions/abcdef1234567890/add_ons/marketing_email/usage"
      pager.resource_class.must_equal Recurly::Usage
    end

    it "must support querying" do
      time = "2016-04-20T16:33:56"

      query = "billing_status=all&datetime_type=usage&end_datetime=#{time}&start_datetime=#{time}"

      stub_api_request(
        :get,
        "subscriptions/abcdef1234567890/add_ons/marketing_email/usage?#{query}",
        'subscriptions/add_ons/usage/index-200'
      )

      options = {
        billing_status: :all,          # (:all || :unbilled || :billed)
        datetime_type: :usage,         # (:usage || :recording)
        start_datetime: time,          # greater than or equal to this date
        end_datetime: time,            # less than this date
      }

      pager.paginate(options).find_each do |usage|
        usage.must_be_instance_of Usage
      end
    end
  end

  describe ".build" do
    it "must be able to build" do
      usage.must_be_instance_of Usage
    end
  end

  describe ".to_xml" do
    it "must serialize to correct xml" do
      time = DateTime.now.strftime
      usage.amount = 10
      usage.merchant_tag = "10 emails delivered for merchant"
      usage.recording_timestamp = time
      usage.usage_timestamp = time
      usage.to_xml.must_equal <<XML.chomp
<usage>\
<amount>10</amount>\
<merchant_tag>10 emails delivered for merchant</merchant_tag>\
<recording_timestamp>#{time}</recording_timestamp>\
<usage_timestamp>#{time}</usage_timestamp>\
</usage>
XML
    end
  end
end
