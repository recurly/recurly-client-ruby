module Recurly
  class Tier < Resource

    belongs_to :add_on
    belongs_to :subscription_add_on

    define_attribute_methods %w(
      ending_quantity
      unit_amount_in_cents
    )

    # to_xml for subscription add-ons
    def to_xml_tier options = {}
      builder = options[:builder] || XML.new('<tiers/>')
      xml_keys.each { |key|
        node = builder.add_element key
        value = key == "unit_amount_in_cents" ?
          # converts Recurly::Money to Integer
          respond_to?(key) ? send(key).to_i : self[key].to_i 
          :
          respond_to?(key) ? send(key) : self[key]
        node.text = value
      }
    builder.to_s
  end

    def xml_keys
      attributes.keys
    end
  end
end
