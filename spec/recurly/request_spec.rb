require "spec_helper"

RSpec.describe Recurly::Request do

  let(:hash_data) do
    {
      a_string: "A String",
      a_hash: {a: 1, b: 2},
      an_integer: 42,
      a_float: 4.2,
      a_boolean: false,
      a_datetime: DateTime.new(2020, 1, 1),
      a_string_array: %w(I am a string array),
      a_sub_request: { a_string: "SubResource String"},
      a_sub_request_array: [{a_string: "SubResource String"}]
    }
  end

  subject { Recurly::Requests::MyRequest.new(hash_data) }

  describe "==" do
    it "should be true when two requests have the same attributes" do
      other = Recurly::Requests::MyRequest.new(hash_data)
      expect(subject).to eq(other)
    end
    it "should be false when two requests have the different attributes" do
      other = Recurly::Requests::MyRequest.new(hash_data)
      other.a_string = "Some other string"
      expect(subject).to_not eq(other)
    end
  end

  describe "#validate!" do
    context "with valid request body" do
      it "should not raise an error" do
        expect { subject.validate! }.not_to raise_error(Exception)
      end
    end
    context "with incorrectly typed data" do
      context "with int instead of string" do
        it "should raise an error" do
          hash_data[:a_string] = 43
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      context "with string instead of hash" do
        it "should raise an error" do
          hash_data[:a_hash] = "Not a hash"
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      context "with string instead of integer" do
        it "should raise an error" do
          hash_data[:an_integer] = "Not an integer"
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      context "with integer instead of float" do
        it "should raise an error" do
          hash_data[:a_float] = 100
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      context "with an incorrectly spelled field" do
        it "should raise an error with did_you_mean description" do
          hash_data[:a_floa] = 100
          expect { subject.validate! }.to raise_error(ArgumentError)
          expect { subject.validate! }.to raise_error(/Attribute 'a_floa' does not exist on request Recurly::Requests::MyRequest. Did you mean 'a_float'?/)
        end
        it "should raise an error with did_you_mean description" do
          hash_data[:a_string_arra] = ['string']
          expect { subject.validate! }.to raise_error(ArgumentError)
          expect { subject.validate! }.to raise_error(/Attribute 'a_string_arra' does not exist on request Recurly::Requests::MyRequest. Did you mean 'a_string_array'?/)
        end
      end
      # TODO implement
      # context "with string instead of boolean" do
      #   it "should raise an error" do
      #     hash_data[:a_boolean] = "Not a boolean"
      #     expect { subject.validate! }.to raise_error(ArgumentError)
      #   end
      # end
      context "with integer instead of DateTime" do
        it "should raise an error" do
          hash_data[:a_datetime] = 42
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      context "with an integer instead of a string array" do
        it "should raise an error" do
          hash_data[:a_string_array] = 42
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      # TODO implement
      # context "with an integer array instead of a string array" do
      #   it "should raise an error" do
      #     hash_data[:a_string_array] = [42]
      #     expect { subject.validate! }.to raise_error(ArgumentError)
      #   end
      # end
      # TODO implement
      # context "with a mixed array instead of a string array" do
      #   it "should raise an error" do
      #     hash_data[:a_string_array] = [42, "a string though"]
      #     expect { subject.validate! }.to raise_error(ArgumentError)
      #   end
      # end
      context "with an invalid subrequest" do
        it "should raise an error" do
          hash_data[:a_sub_request] = { a_string: 42 }
          expect { subject.validate! }.to raise_error(ArgumentError)
        end
      end
      # TODO implement
      # context "with an invalid subrequest array" do
      #   it "should raise an error" do
      #     hash_data[:a_sub_request_array] = [{ a_string: 42 }]
      #     expect { subject.validate! }.to raise_error(ArgumentError)
      #   end
      # end
    end
  end

  describe "#cast" do
    context "with primitive Hash type" do
      it "should not transform the same Hash" do
        casted = Recurly::Requests::MyRequest.cast(hash_data)
        expect(casted).to eql(hash_data)
      end
    end
    context "with mixed types" do
      it "should not cast the Resource to a Hash" do
        hash_data[:a_sub_request] = Recurly::Requests::MySubRequest.new(a_string: 'a_string')
        hash_data[:a_sub_request_array] = [Recurly::Requests::MySubRequest.new(a_string: 'a_string')]
        casted = Recurly::Requests::MyRequest.cast(hash_data)
        expect(casted).to_not eql(hash_data)
        expect(casted[:a_sub_request]).to eql(a_string: 'a_string')
        expect(casted[:a_sub_request_array]).to eql([a_string: 'a_string'])
      end
    end
  end

  context "request type" do
    req_names = Recurly::Requests.constants - [:MyRequest, :MySubRequest]
    req_names.each do |req_name|
      context req_name do
        let(:req_class) { Recurly::Requests.const_get(req_name) }

        it "should have a schema" do
          expect(req_class.schema).to be_instance_of(Recurly::Schema)
        end

        it "should have an attributes hash" do
          expect(req_class.new.attributes).to be_instance_of(Hash)
        end

        it "should respond to validate!" do
          expect(req_class.new).to respond_to(:validate!)
        end
      end
    end
  end
end
