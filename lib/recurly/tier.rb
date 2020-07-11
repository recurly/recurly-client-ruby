module Recurly
  class Tier < Resource

    belongs_to :add_on
    belongs_to :subscription_add_on

    define_attribute_methods %w(
      ending_quantity
      unit_amount_in_cents
    )

    def to_xml_tier options = {}
      builder = options[:builder] || XML.new('<tiers/>')
      xml_keys.each { |key|
        node = builder.add_element key
        if key == "unit_amount_in_cents"
          value = respond_to?(key) ? send(key).to_i : self[key].to_i
        else
          value = respond_to?(key) ? send(key) : self[key]
        end
        node.text = value
      }
    builder.to_s
  end

    def xml_keys
      attributes.keys
    end
  end
end
