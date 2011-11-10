require 'spec_helper'

describe Recurly::XML do
  describe ".filter" do
    it "must filter sensitive data only on number and verification_value" do
      [
        [
          '<billing_info><number>4111111111111111</number></billing_info>',
          '<billing_info><number>************1111</number></billing_info>'
        ],
        [
          '<account><billing_info><number>4111-1111-1111-1111</number></billing_info></account>',
          '<account><billing_info><number>****-****-****-1111</number></billing_info></account>'
        ],
        [
          '<account><billing_info><number>123</number></billing_info></account>',
          '<account><billing_info><number></number></billing_info></account>'
        ],
        [
          '<subscription><account><billing_info><verification_value>123</verification_value></billing_info></account></subscription>',
          '<subscription><account><billing_info><verification_value>***</verification_value></billing_info></account></subscription>'
        ],
        [
          '<subscription><account><billing_info><vat_number>DE123456789</vat_number></billing_info></account></subscription>',
          '<subscription><account><billing_info><vat_number>DE123456789</vat_number></billing_info></account></subscription>'
        ]
      ].each do |input, output|
        Recurly::XML.filter(input).must_equal output
      end
    end
  end

  describe ".text" do
    before :each do
      @sample_xml = Recurly::XML.new("<root><node>Text from node</node>Text from root</root>")
    end

    it "should return the first child text node" do
      @sample_xml.text.must_equal "Text from root"
    end

    it "should return the first child text node at the given xpath" do
      @sample_xml.text("//node").must_equal "Text from node"
    end

    it "should return nil if no node is found" do
      @sample_xml.text("//idontexist").must_be_nil
    end
  end
end
