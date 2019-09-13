require 'spec_helper'

describe GiftCard do
  let(:gift_card) {
    stub_api_request :get, 'gift_cards/2004005808969875135', 'gift_cards/show-200'
    Recurly::GiftCard.find 2004005808969875135
  }

  let(:gift_cards) {
    stub_api_request :get, 'gift_cards', 'gift_cards/index-200'
    Recurly::GiftCard.all
  }

  describe "#all" do
    it "should return list of cards" do
      gift_cards.length.must_equal 2
    end

    it "should have redemption codes" do
      gift_cards.map(&:redemption_code).must_equal ["8ED8CE30641A92E4", "91EF1F5FD6437C83"]
    end
  end

  describe "#to_param" do
    it "should return id" do
      gift_card.to_param.must_equal 2004005808969875135
    end
  end

  describe "#find" do
    it "should find a gift card" do
      gift_card.must_be_instance_of Recurly::GiftCard
    end

    it "should parse all the gift card fields" do
      gift_card.balance_in_cents.must_equal 1_000
      gift_card.currency.must_equal "USD"
      gift_card.created_at.must_equal DateTime.parse("2016-07-28T00:01:48Z")
      gift_card.canceled_at.must_equal nil
      gift_card.delivered_at.must_equal nil
      gift_card.id.must_equal 2004005808969875135
      gift_card.product_code.must_equal "gift_card"
      gift_card.redeemed_at.must_equal DateTime.parse("2016-07-28T00:01:46Z")
      gift_card.redemption_code.must_equal "8ED8CE30641A92E4"
      gift_card.unit_amount_in_cents.must_equal 2_000
      gift_card.updated_at.must_equal DateTime.parse("2016-07-28T00:01:46Z")

      stub_api_request :get, 'invoices/1017', 'invoices/show-200'
      gift_card.redemption_invoice.must_be_instance_of Invoice
      stub_api_request :get, 'invoices/1017', 'invoices/show-200'
      gift_card.purchase_invoice.must_be_instance_of Invoice

      delivery = gift_card.delivery

      delivery.must_be_instance_of Recurly::Delivery
      delivery.method.must_equal "email"
      delivery.deliver_at.must_equal nil
      delivery.email_address.must_equal "john@example.com"
      delivery.first_name.must_equal "John"
      delivery.last_name.must_equal "Smith"
      delivery.gifter_name.must_equal "Sally"
      delivery.personal_message.must_equal "Thanks John! -- sally"

      address = delivery.address

      address.address1.must_equal "400 Alabama St"
      address.address2.must_equal nil
      address.city.must_equal "San Francisco"
      address.state.must_equal "CA"
      address.zip.must_equal "94110"
      address.country.must_equal "US"
      address.phone.must_equal "337-555-5555"
    end
  end

  describe "#to_xml" do
    describe "with existing (purchased) gift card" do
      it "should render an existing gift_card with just the redemption_code" do
        expected = <<-XML
          <gift_card>
            <redemption_code>8ED8CE30641A92E4</redemption_code>
          </gift_card>
        XML

        expected = expected.gsub("\n", "").gsub(" ", "")
        gift_card.to_xml.must_equal expected
      end
    end
    describe "when creating the account with the gift card purchase" do
      let(:account_data) do
        {
          account_code: 'existing_account_code',
          email: 'sally@example.com',
          first_name: 'Sally',
          last_name: 'Smith',
          billing_info: {
            address1: '400 Alabama St',
            zip: '94110',
            city: 'San Francisco',
            state: 'CA',
            country: 'US',
            number: '4111-1111-1111-1111',
            month: 12,
            year: 2019
          }
        }
      end
      let(:delivery_data) do
        {
          method: 'email',
          email_address: 'john@example.com',
          first_name: 'John',
          last_name: 'Smith',
          gifter_name: 'Sally',
          personal_message: 'Thanks John! -- sally'
        }
      end
      let(:gift_card) {
        Recurly::GiftCard.new(
          product_code: 'gift_card',
          currency: 'USD',
          unit_amount_in_cents: 2000,
          gifter_account: account_data,
          delivery: delivery_data
        )
      }

      it "should embed the account and delivery xml" do
        expected_xml = <<-XML
        <gift_card>
          <currency>USD</currency>
          <delivery>
            <email_address>john@example.com</email_address>
            <first_name>John</first_name>
            <gifter_name>Sally</gifter_name>
            <last_name>Smith</last_name>
            <method>email</method>
            <personal_message>Thanks John! -- sally</personal_message>
          </delivery>
          <gifter_account>
            <account_code>existing_account_code</account_code>
            <billing_info>
              <address1>400AlabamaSt</address1>
              <city>SanFrancisco</city>
              <country>US</country>
              <month>12</month>
              <number>4111-1111-1111-1111</number>
              <state>CA</state>
              <year>2019</year>
              <zip>94110</zip>
            </billing_info>
            <email>sally@example.com</email>
            <first_name>Sally</first_name>
            <last_name>Smith</last_name>
          </gifter_account>
          <product_code>gift_card</product_code>
          <unit_amount_in_cents>2000</unit_amount_in_cents>
        </gift_card>
        XML

        expected_xml = expected_xml.gsub("\n", "").gsub(" ", "")
        actual_xml = gift_card.to_xml.gsub("\n", "").gsub(" ", "")

        actual_xml.must_equal expected_xml
      end
    end

    describe "when adding a top level billing info" do
      let(:gift_card) {
        Recurly::GiftCard.new(
          billing_info: Recurly::BillingInfo.new(token_id: '1234')
        )
      }

      it "should embed the billing info" do
        expected_xml = <<-XML
        <gift_card>
          <billing_info>
            <token_id>1234</token_id>
          </billing_info>
        </gift_card>
        XML

        expected_xml = expected_xml.gsub("\n", "").gsub(" ", "")
        actual_xml = gift_card.to_xml.gsub("\n", "").gsub(" ", "")

        actual_xml.must_equal expected_xml
      end
    end
  end
end
