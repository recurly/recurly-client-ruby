require 'spec_helper'

describe ExternalSubscription do
  let(:external_subscription) {
    ExternalSubscription.new(
      external_reference_id: "gold",
      quantity: 1,
      activated_at: "2022-11-07 17:08:18", 
      created_at: "2022-11-07 17:08:18", 
      expires_at: "2022-12-07 17:08:18",
      updated_at: "2022-11-07 17:08:18",
      last_purchased: "2022-11-07 17:08:18",
      auto_renew: true,
      app_identifier: 'apple_play_store',
    )
  }

  describe 'serializing the record' do

    before do
      external_subscription.account = Account.new(account_code: 'account code')
      external_subscription.external_resource = ExternalResource.new(external_object_reference: 'reference')
      external_subscription.external_product_reference = ExternalProductReference.new(
        reference_code: 'reference_code 1',
        external_connection_type: 'apple_app_store',
        id: 'abc123',
        created_at: '2022-11-07 17:08:18',
        updated_at: '2022-11-07 17:08:18'
      )
    end

    it 'must serialize' do
      external_subscription.to_xml.must_equal <<XML.chomp
<external_subscription>\
<account><account_code>account code</account_code></account>\
<activated_at>2022-11-07 17:08:18</activated_at>\
<app_identifier>apple_play_store</app_identifier>\
<auto_renew>true</auto_renew>\
<created_at>2022-11-07 17:08:18</created_at>\
<expires_at>2022-12-07 17:08:18</expires_at>\
<external_product_reference>\
<created_at>2022-11-07 17:08:18</created_at>\
<external_connection_type>apple_app_store</external_connection_type>\
<id>abc123</id>\
<reference_code>reference_code 1</reference_code>\
<updated_at>2022-11-07 17:08:18</updated_at>\
</external_product_reference>\
<external_reference_id>gold</external_reference_id>\
<external_resource><external_object_reference>reference</external_object_reference></external_resource>\
<last_purchased>2022-11-07 17:08:18</last_purchased>\
<quantity>1</quantity>\
<updated_at>2022-11-07 17:08:18</updated_at>\
</external_subscription>
XML

    end
  end
end
