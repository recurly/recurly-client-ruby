require "spec_helper"

RSpec.describe Recurly::Resource do
  context "with a valid resource" do
    let(:json_data) do
      {
        "object" => "my_resource",
        "a_string" => "A String",
        "a_hash" => { "a" => 1, "b" => 2 },
        "an_integer" => 42,
        "a_float" => 4.2,
        "a_boolean" => false,
        "a_datetime" => DateTime.new(2020, 1, 1),
        "a_string_array" => %w(I am a string array),
        "a_sub_resource" => { "a_string" => "SubResource String", "object" => "my_sub_resource" },
        "a_sub_resource_array" => [{ "a_string" => "SubResource String", "object" => "my_sub_resource" }],
      }
    end

    subject! { Recurly::Resources::MyResource.from_json(json_data) }

    describe "#attributes" do
      let(:attributes) { subject.attributes }

      it "returns a Hash" do
        attributes.is_a? Hash
      end

      # TODO expecting to turn hash elements into keys
      # TODO expecting use overridden == for resources
      # it "returns the expected Hash" do
      #   expect(attributes).to eq({
      #     a_string: "A String",
      #     a_hash: {a: 1, b: 2},
      #     an_integer: 42,
      #     a_float: 4.2,
      #     a_boolean: false,
      #     a_datetime: DateTime.new(2020, 1, 1),
      #     a_string_array: %w(I am a string array),
      #     a_sub_resource: Recurly::Resources::MySubResource.from_json({ "a_string" => "SubResource String" }),
      #     a_sub_resource_array: [Recurly::Resources::MySubResource.from_json({"a_string" => "SubResource String"})]
      #   })
      # end
    end

    describe "attributes methods" do
      it "should respond to a_string" do
        expect(subject.send(:a_string)).to eq("A String")
      end
      # TODO expecting to turn hash elements into keys
      # it "should respond to a_hash" do
      #   expect(subject.send(:a_hash)).to eq({a: 1, b: 2})
      # end
      it "should respond to an_integer" do
        expect(subject.send(:an_integer)).to eq(42)
      end
      it "should respond to a_float" do
        expect(subject.send(:a_float)).to eq(4.2)
      end
      it "should respond to a_boolean" do
        expect(subject.send(:a_boolean)).to eq(false)
      end
      it "should respond to a_datetime" do
        expect(subject.send(:a_datetime)).to eq(DateTime.new(2020, 1, 1))
      end
      it "should respond to a_string_array" do
        expect(subject.send(:a_string_array)).to eq(%w(I am a string array))
      end
      it "should respond to a_sub_resource" do
        expect(subject.send(:a_sub_resource)).to eq(Recurly::Resources::MySubResource.from_json({ "a_string" => "SubResource String" }))
      end
      it "should respond to a_sub_resource_array" do
        expect(subject.send(:a_sub_resource_array)).to eq([Recurly::Resources::MySubResource.from_json({ "a_string" => "SubResource String" })])
      end
    end

    context "with currencies" do
      let(:json_data) {
        {
          "pricing" => [
            {
              "currency" => "USD",
              "amount" => 123,
            },
            {
              "currency" => "EUR",
              "amount" => 456,
            },
          ],
        }
      }

      describe "pricing" do
        it "should be a CurrencyArray" do
          expect(subject.pricing).to be_instance_of Recurly::CurrencyArray
        end
      end
      describe "a_string_array" do
        it "should not be a CurrencyArray" do
          expect(subject.a_string_array).to_not be_instance_of Recurly::CurrencyArray
        end
      end
      describe "a_sub_resource_array" do
        it "should not be a CurrencyArray" do
          expect(subject.a_sub_resource_array).to_not be_instance_of Recurly::CurrencyArray
        end
      end
    end
  end

  context "resource type" do
    res_names = Recurly::Resources.constants - [:MyResource, :MySubResource]
    res_names.each do |res_name|
      context res_name do
        let(:res_class) { Recurly::Resources.const_get(res_name) }

        it "should have a schema" do
          expect(res_class.schema).to be_instance_of(Recurly::Schema)
        end

        it "should have an attributes hash" do
          expect(res_class.new.attributes).to be_instance_of(Hash)
        end

        it "should respond to validate!" do
          expect(res_class.new).to respond_to(:validate!)
        end

        it "should be buildable from json data" do
          expect(res_class.from_json({})).to be_instance_of(res_class)
        end
      end
    end
  end
end
