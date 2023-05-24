module Recurly
  class ExternalProduct < Resource

    # @return [Plan]
    belongs_to :plan

    # @return array [ExternalProductReference]
    has_many :external_product_references

    define_attribute_methods %w(
      name
      created_at
      updated_at
    )

    def create_external_product_reference(external_product_reference)
      external_product_reference.uri = "#{path}/external_product_references"
      external_product_reference.save!
      external_product_reference
    end

    def get_external_product_references
      Pager.new(Recurly::ExternalProductReference, uri: "#{path}/external_product_references", parent: self)
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end

    def get_external_product_reference(external_product_reference_uuid)
      ExternalProductReference.from_response API.get("#{path}/external_product_references/#{external_product_reference_uuid}")
    rescue Recurly::API::UnprocessableEntity => e
      raise Invalid, e.message
    end
  end
end
