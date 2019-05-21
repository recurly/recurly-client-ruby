require "spec_helper"
require "date"

RSpec.describe Recurly::Errors::APIError do
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
