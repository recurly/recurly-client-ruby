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
      proc { Recurly.js.private_key }.must_raise ConfigurationError
    end

    it "must raise an exception when set to nil" do
      Recurly.js.private_key = nil
      proc { Recurly.js.private_key }.must_raise ConfigurationError
    end
  end

  describe "public_key" do
    it "must be assignable" do
      js.public_key = 'a_public_key'
      js.public_key.must_equal 'a_public_key'
    end

    it "must raise an exception when not set" do
      if js.instance_variable_defined? :@public_key
        js.send :remove_instance_variable, :@public_key
      end
      proc { Recurly.js.public_key }.must_raise ConfigurationError
    end

    it "must raise an exception when set to nil" do
      Recurly.js.public_key = nil
      proc { Recurly.js.public_key }.must_raise ConfigurationError
    end
  end

  describe ".sign" do
    let(:sign) { js.method :sign }
    let(:private_key) { '0123456789abcdef0123456789abcdef' }
    let(:timestamp) { 1329942896 }

    class MockTime
      class << self
        attr_accessor :now
      end
    end

    class MockBase64
      class << self
        def encode64(*) 'unique' end
      end
    end

    before do
      js.private_key = '0123456789abcdef0123456789abcdef'
      @time = Time
      Object.const_set :Time, MockTime
      Time.now = @time.at timestamp
      @base64 = Base64
      Object.const_set :Base64, MockBase64
    end

    after do
      Object.const_set :Time, @time
      Object.const_set :Base64, @base64
    end

    it "must sign transaction request" do
      Recurly.js.sign(
        'account' => { 'account_code' => '123' },
        'transaction' => {
          'amount_in_cents' => 5000,
          'currency' => 'USD'
        }
      ).must_equal <<EOS.chomp
95c000d2aa045cb20596b8a751b08c8dfaee8cf2|\
account%5Baccount_code%5D=123&\
nonce=unique&\
timestamp=1329942896&\
transaction%5Bamount_in_cents%5D=5000&\
transaction%5Bcurrency%5D=USD
EOS
    end

    it "must sign subscription request" do
      Recurly.js.sign(
        'account' => { 'account_code' => '123' },
        'subscription' => {
          'plan_code' => 'gold'
        }
      ).must_equal <<EOS.chomp
295bd0626ab03fd01053fb0784bd5187b563cbeb|\
account%5Baccount_code%5D=123&\
nonce=unique&\
subscription%5Bplan_code%5D=gold&\
timestamp=1329942896
EOS
    end

    describe "object signatures" do
      it "must sign update billing info request" do
        billing_info = Account.new(:account_code => '123')
        Recurly.js.sign(billing_info).must_equal <<EOS.chomp
86509e315e8396423e420839a9c4cbafd5f230f3|\
account%5Baccount_code%5D=123&\
nonce=unique&\
timestamp=1329942896
EOS
      end

      it "must sign subscription request" do
        subscription = Subscription.new :plan_code => 'gold'
        account = Account.new :account_code => '123'
        Recurly.js.sign(subscription, account).must_equal <<EOS.chomp
c74db6318765b7f3e0e31ad54a7773000646df0b|\
account%5Baccount_code%5D=123&\
nonce=unique&\
subscription%5Bcurrency%5D=USD&\
subscription%5Bplan_code%5D=gold&\
timestamp=1329942896
EOS
      end

      it "must sign transaction request" do
        transaction = Transaction.new :amount_in_cents => 50_00
        transaction.persist!
        account = Account.new :account_code => '123'
        Recurly.js.sign(transaction, account).must_equal <<EOS.chomp
95c000d2aa045cb20596b8a751b08c8dfaee8cf2|\
account%5Baccount_code%5D=123&\
nonce=unique&\
timestamp=1329942896&\
transaction%5Bamount_in_cents%5D=5000&\
transaction%5Bcurrency%5D=USD
EOS
      end
    end
  end
end
