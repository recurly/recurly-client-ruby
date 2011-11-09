require 'spec_helper'

describe Recurly::XML do
  describe ".filter" do
    it "must filter sensitive data" do
      [
        [
          '<billing_info><number>************1111</number></billing_info>'
          '<billing_info><number>4111111111111111</number></billing_info>',
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
        ]
      ].each do |input, output|
        Recurly::XML.filter(input).must_equal output
      end
    end
  end
end
