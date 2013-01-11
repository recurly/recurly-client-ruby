module ActiveModel
  module Serializers
    module Xml

      # Patch for Rails 3.0 to properly serialize nil values (without type="yaml")
      #
      #   This issue was fixed in Rails 3.0.20 by this pull request:
      #     https://github.com/rails/rails/pull/8853

      class Serializer
        class Attribute

        protected

          def compute_type
            return if value.nil?
            type = ActiveSupport::XmlMini::TYPE_NAMES[value.class.name]
            type ||= :string if value.respond_to?(:to_str)
            type ||= :yaml
            type
          end

        end
      end

    end
  end
end