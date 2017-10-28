require 'spec_helper'

describe Webhook::PurchasedGiftCardNotification do
  let(:notification) { Webhook::PurchasedGiftCardNotification.from_xml(get_raw_xml 'webhooks/purchased-gift-card-notification.xml') }

  describe "gift_card" do
    it "must return the gift card" do
      notification.gift_card.must_be_instance_of GiftCard
    end

    it "must have an account_code" do
      notification.gift_card.id.must_equal 1
    end
  end

end
