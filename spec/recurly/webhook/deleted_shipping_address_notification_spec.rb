require 'spec_helper'

describe Webhook::DeletedShippingAddressNotification do
  let (:notification) { Webhook::DeletedShippingAddressNotification.from_xml(get_raw_xml 'webhooks/deleted-shipping-address-notification.xml') }

  describe "account" do
    it "must return the account" do
      notification.account.must_be_instance_of Account
    end
  end
  
  describe "shipping_address" do
    it "must return the shipping address" do
      notification.shipping_address.must_be_instance_of ShippingAddress
    end
  end
end