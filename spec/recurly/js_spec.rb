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
        :a => [1, 2, 3], :b => { :c => '123', :d => '456' }
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
    let(:sign) { js.method :sign }
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

    it "must generate proper signatures" do
      sig = sign.call 'update', :a => 'foo', :b => 'bar'
      sig.must_equal signature
    end

    it "must sign subscription" do
      sig = js.method(:sign_subscription).call 'acc', :a => { :a1 => 'v' }
      sig.must_equal 'f85e8ea59232af127ff417773027da927fcd15d0-1312806801+a.a1'
    end

    it "must sign billing_info" do
      sig = js.method(:sign_billing_info).call 'acc', :a => {:a1 => 'v'}
      sig.must_equal '796e4f02e24ee5fc8a248f8ff123749e08a033da-1312806801+a.a1'
    end

    it "must sign transaction" do
      sig = js.method(:sign_transaction).call(
        50_00, 'USD', 'acc', :a => {:a1 => 'v'}
      )
      sig.must_equal '16754dea33128cb3a83bcd7ca937ca45742739e7-1312806801+a.a1'
    end

    it "must validate proper signatures" do
      verify.call 'update', :a => 'foo', :b => 'bar', :signature => signature
    end

    it "must reject invalid signatures" do
      proc {
        verify.call 'update', :a => 'foo', :b => 'bar', :signature => 'baz'
      }.must_raise js::RequestForgery
    end

    it "must merge extras into hmac and append their keys to the signature" do
      signed = sign.call('update', { :a => 'foo', :b => 'bar' },
        { :acct => { :name => 'joe' } }
      )
      signed.must_equal(
        "1b85c19394eaea131a8d43eaada91634625d8f18-#{timestamp}+acct.name"
      )
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
    it "must verify billing info" do
      js.verify_billing_info!(
        'signature' => "07e7bea6a5bcb65d8dd93f8e314b2dab686c8ca8-#{timestamp}"
      )
    end

    it "must verify subscriptions" do
      js.verify_subscription!(
        'signature' => "1b0cddbdfaabd9e1a1e3e3b309f5809f66d04515-#{timestamp}"
      )
    end

    it "must verify transactions" do
      js.verify_transaction!(
        'signature' => "771f82bd339bbad93e5bd9eae279cfdeb9c4773b-#{timestamp}"
      )
    end
  end

  describe "collect_keypaths" do
    let(:collect_keypaths) { js.method :collect_keypaths }
    it "must collect keypaths" do
      test_obj = {:a => {:a1 => 'a1', :a2 => 'a2'}, :b => 'b'}
      keypaths = collect_keypaths.call(test_obj)
      keypaths.must_equal ['a.a1','a.a2','b']
    end
  end

end
