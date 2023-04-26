# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  module Resources
    class CustomFieldDefinition < Resource

      # @!attribute created_at
      #   @return [DateTime] Created at
      define_attribute :created_at, DateTime

      # @!attribute deleted_at
      #   @return [DateTime] Definitions are initially soft deleted, and once all the values are removed from the accouts or subscriptions, will be hard deleted an no longer visible.
      define_attribute :deleted_at, DateTime

      # @!attribute display_name
      #   @return [String] Used to label the field when viewing and editing the field in Recurly's admin UI.
      define_attribute :display_name, String

      # @!attribute id
      #   @return [String] Custom field definition ID
      define_attribute :id, String

      # @!attribute name
      #   @return [String] Used by the API to identify the field or reading and writing. The name can only be used once per Recurly object type.
      define_attribute :name, String

      # @!attribute object
      #   @return [String] Object type
      define_attribute :object, String

      # @!attribute related_type
      #   @return [String] Related Recurly object type
      define_attribute :related_type, String

      # @!attribute tooltip
      #   @return [String] Displayed as a tooltip when editing the field in the Recurly admin UI.
      define_attribute :tooltip, String

      # @!attribute updated_at
      #   @return [DateTime] Last updated at
      define_attribute :updated_at, DateTime

      # @!attribute user_access
      #   @return [String] The access control applied inside Recurly's admin UI: - `api_only` - No one will be able to view or edit this field's data via the admin UI. - `read_only` - Users with the Customers role will be able to view this field's data via the admin UI, but   editing will only be available via the API. - `write` - Users with the Customers role will be able to view and edit this field's data via the admin UI. - `set_only` - Users with the Customers role will be able to set this field's data via the admin console.
      define_attribute :user_access, String
    end
  end
end
