require 'spec_helper'

describe Recurly do
  describe "api key" do
    before { @old_api_key = Recurly.api_key }
    after  { Recurly.api_key = @old_api_key }

    it "must be assignable" do
      Recurly.api_key = 'new_key'
      Recurly.api_key.must_equal 'new_key'
    end

    it "must raise an exception when not set" do
      if Recurly.instance_variable_defined? :@api_key
        Recurly.send :remove_instance_variable, :@api_key
      end
      Thread.new {
        proc { Recurly.api_key }.must_raise ConfigurationError
      }.join
    end

    it "must raise an exception when set to nil" do
      Recurly.api_key = nil
      proc { Recurly.api_key }.must_raise ConfigurationError
    end

    it "has different api keys for different threads" do
      Recurly.api_key = "123"
      Thread.new { Recurly.api_key = "456" }.join
      Recurly.api_key.must_equal "123"
    end
  end
end
