require 'spec_helper'

describe Recurly do
  describe "api key" do

    it "must be assignable" do
      Recurly.api_key = 'new_key'
      Recurly.api_key.must_equal 'new_key'
    end

    it "must raise an exception when not set" do
      if Recurly.instance_variable_defined? :@api_key
        Recurly.send :remove_instance_variable, :@api_key
      end
      proc { Recurly.api_key }.must_raise ConfigurationError
    end

    it "must raise an exception when set to nil" do
      Recurly.api_key = nil
      proc { Recurly.api_key }.must_raise ConfigurationError
    end

    it "must use defaults set if not sent in new thread" do
      Recurly.api_key = 'old_key'
      Recurly.subdomain = 'olddomain'
      Recurly.default_currency = 'US'
      Thread.new {
        Recurly.api_key.must_equal 'old_key'
        Recurly.subdomain.must_equal 'olddomain'
        Recurly.default_currency.must_equal 'US'
      }
    end

    it "must use new values set in thread context" do
      Recurly.api_key = 'old_key'
      Recurly.subdomain = 'olddomain'
      Recurly.default_currency = 'US'
      Thread.new {
          Recurly.config(api_key: "test", subdomain: "testsub", default_currency: "IR")
          Recurly.api_key.must_equal 'test'
          Recurly.subdomain.must_equal 'testsub'
          Recurly.default_currency.must_equal 'IR'
      }
      Recurly.api_key.must_equal 'old_key'
      Recurly.subdomain.must_equal 'olddomain'
      Recurly.default_currency.must_equal 'US'
    end
  end
end
