require 'spec_helper'

describe Webhook::NewShippingAddressNotification do
  let (:notification) { Webhook::NewShippingAddressNotification.from_xml(get_raw_xml 'webhooks/new-shipping-address-notification.xml') }

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