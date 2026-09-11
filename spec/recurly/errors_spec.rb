require "spec_helper"
require "date"

RSpec.describe Recurly::Errors::APIError do
  describe ".from_response" do
    it "maps a known response code to its error class" do
      response = double("response", code: "404")
      expect(described_class.from_response(response)).to eq(Recurly::Errors::NotFoundError)
    end

    it "falls back to APIError for an unknown response code" do
      response = double("response", code: "999")
      expect(described_class.from_response(response)).to eq(Recurly::Errors::APIError)
    end

    it "raises a RuntimeError if error_map was never set" do
      allow(described_class).to receive(:error_map).and_raise(RuntimeError, "error_map must be set by the generated api_errors.rb file")
      response = double("response", code: "404")

      expect { described_class.from_response(response) }.to raise_error(RuntimeError, /error_map must be set/)
    end
  end

  describe ".error_class" do
    error_keys = Recurly::Errors.constants - [:APIError]
    error_keys = error_keys.map do |key|
      key.to_s.split(/(?=[A-Z])/).map(&:downcase).join("_")
    end

    error_keys.each do |error_key|
      it "should turn the error key #{error_key} into an error class" do
        err_class = described_class.error_class(error_key)
        expect(err_class.ancestors).to include(StandardError)
      end
    end
  end
end
