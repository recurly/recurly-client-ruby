module Recurly
  class Item < Resource
    # @return [[CustomField], []]
    has_many :custom_fields, class_name: :CustomField, readonly: false

    define_attribute_methods %w(
      item_code
      name
      description
      external_sku
      accounting_code
      revenue_schedule_type
      state
      created_at
      updated_at
      deleted_at
      total_amount_in_cents
    )

    def changed_attributes
      attrs = super
      if custom_fields.any?(&:changed?)
        attrs['custom_fields'] = custom_fields.select(&:changed?)
      end
      attrs
    end

    # method should be changed to use a link once it is added to api
    # example:
    #   return false unless link? :reactivate
    #   reload follow_link :reactivate
    def reactivate
      reload API.put("#{uri}/reactivate")
      true
    end

  end
end
