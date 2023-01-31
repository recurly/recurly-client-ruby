require 'spec_helper'

describe CustomFieldDefinition do
  describe ".find" do
    before do
      stub_api_request(
        :get, "custom_field_definitions/3722298505492673710", "custom_field_definition/show-200"
      )
    end

    it "returns a custom field definition" do
      definition = CustomFieldDefinition.find("3722298505492673710")

      definition.must_be_instance_of(CustomFieldDefinition)
      definition.id.must_equal("3722298505492673710")
      definition.related_type.must_equal("plan")
      definition.name.must_equal("package")
      definition.user_access.must_equal("writable")
      definition.display_name.must_equal("Package")
      definition.tooltip.must_equal("Value can be 'Basic' or 'Premium'")
      definition.created_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 40))
      definition.updated_at.must_equal(DateTime.new(2023, 1, 23, 19, 2, 47))
    end
  end

  describe ".all" do
    before do
      stub_api_request(
        :get, "custom_field_definitions", "custom_field_definition/index-200"
      )
    end

    it "returns a list of custom field definitions" do
      definitions = CustomFieldDefinition.all

      definitions.must_be_instance_of(Array)
      definitions.count.must_equal(2)
      definitions.first.related_type.must_equal("item")
      definitions.last.related_type.must_equal("plan")
    end
  end

  describe "when the request is filtered by 'related_type'" do
    before do
      stub_api_request(
        :get, "custom_field_definitions?related_type=plan", "custom_field_definition/index-200-filtered"
      )
    end

    it "returns a list of the filtered results" do
      definitions = CustomFieldDefinition.all(related_type: "plan")

      definitions.must_be_instance_of(Array)
      definitions.count.must_equal(2)
      definitions.first.related_type.must_equal("plan")
      definitions.last.related_type.must_equal("plan")
    end
  end
end
