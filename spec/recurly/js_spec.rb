require 'spec_helper'

describe Recurly.js do
  let(:js) { Recurly.js }

  describe "private_key" do
    it "must be assignable" do
      js.private_key = 'a_private_key'
      js.private_key.must_equal 'a_private_key'
    end

    it "must raise an exception when not set" do
      if js.instance_variable_defined? :@private_key
        js.send :remove_instance_variable, :@private_key
      end
      proc { js.private_key }.must_raise ConfigurationError
    end

    it "must raise an exception when set to nil" do
      js.private_key = nil
      proc { js.private_key }.must_raise ConfigurationError
    end
  end

  describe "digest" do
    let(:digest) { js.method :digest }

    it "must ignore empty arrays, hashes, strings, and nil" do
      digest.call([[], {}, '', nil]).must_equal '[]'
    end

    it "must encode nested arrays and hashes" do
      digest.call(
        { :a => [1, 2, 3], :b => { :c => '123', :d => '456' } }
      ).must_equal '[a:[1,2,3],b:[c:123,d:456]]'
    end

    it "must alphabetize keys" do
      digest.call(:a => 1, :c => 3, :b => 2).must_equal '[a:1,b:2,c:3]'
    end

    it "must treat hashes with numeric indices as arrays" do
      digest.call('1' => 4, '2' => 5, '3' => 6).must_equal '[4,5,6]'
    end

    it "must escape syntax characters" do
      digest.call(:syntax => ' \\ [ ] : , ').must_equal(
        '[syntax: \\\\ \[ \] \: \, ]'
      )
    end
  end

  describe "verification" do
    let(:verify) { js.method :verify! }
    let(:private_key) { '0123456789abcdef0123456789abcdef' }
    let(:timestamp) { 1312806801 }
    let(:signature) { "fb5194a51aa97996cdb995a89064764c5c1bfd93-#{timestamp}" }

    class MockTime
      class << self
        attr_accessor :now
      end
    end

    before do
      js.private_key = private_key
      @time = Time
      Object.const_set :Time, MockTime
      Time.now = @time.at timestamp
    end

    after do
      Object.const_set :Time, @time
    end

    it "must validate proper signatures" do
      verify.call 'update', :a => 'foo', :b => 'bar', :signature => signature
    end

    it "must reject invalid signatures" do
      proc {
        verify.call 'update', :a => 'foo', :b => 'bar', :signature => 'baz'
      }.must_raise js::RequestForgery
    end

    it "must reject a stale signature" do
      Time.now = @time.at(timestamp + 7200)
      proc {
        verify.call(
          'update', :a => 'foo', :b => 'bar', :signature => signature
        )
      }.must_raise js::RequestForgery
    end

    it "must reject time traveling signatures from the future" do
      Time.now = @time.at(timestamp - 7200)
      proc {
        verify.call(
          'update', :a => 'foo', :b => 'bar', :signature => signature
        )
      }.must_raise js::RequestForgery
    end
  end
end
