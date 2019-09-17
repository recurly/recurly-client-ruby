require 'spec_helper'

describe Webhook::UpdatedGiftCardNotification do
  let(:notification) { Webhook::UpdatedGiftCardNotification.from_xml(get_raw_xml 'webhooks/updated-gift-card-notification.xml') }

  describe "gift_card" do
    it "must return the gift card" do
      notification.gift_card.must_be_instance_of GiftCard
    end

    it "must have an account_code" do
      notification.gift_card.id.must_equal 2008976331180115114
    end
  end
end
