require 'spec_helper'

module Recurly
  describe Verification do
    origin_time = 1312806801
    test_sig = 'fb5194a51aa97996cdb995a89064764c5c1bfd93-1312806801'

    before(:each) do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/recurly.yml")
      Recurly::private_key = '0123456789abcdef0123456789abcdef' # Used for testing
    end

    it "should ignore empty arrays, hashes, strings, and nil" do
      Verification::digest_data([
        [], {}, '', nil
      ]).should == '[]'
    end

    it "should encode nested arrays and hashes" do
      Verification::digest_data( 
        {a: [1,2,3], b: {c: '123', d:'456'}}
      ).should == '[a:[1,2,3],b:[c:123,d:456]]'
    end

    it "should treat hashes with numeric indexes as arrays" do
      Verification::digest_data( 
        {'1' => 4, '2' => 5, '3' => 6}
      ).should == '[4,5,6]'
    end

    it "should escape syntax characters" do
      Verification::digest_data(
        {syntaxchars: ' \\ [ ] : , '}
      ).should == '[syntaxchars: \\\\ \[ \] \: \, ]'
    end

    it "should generate proper signatures" do
      Time.stub!(:now).and_return(origin_time) # gen at origin time
      sig = Verification.generate_signature('update',{a:'foo',b:'bar'})
      sig.should == test_sig
    end

    it "should validate proper signatures" do
      Time.stub!(:now).and_return(Time.at(origin_time+60)) # one minute passed
      lambda {
        good = Verification.verify_params!('update',
                           {a:'foo',b:'bar',signature:test_sig})
      }.should_not raise_error
    end

    it "should reject invalid signature" do
      Time.stub!(:now).and_return(Time.at(origin_time+60)) # one minute passed
      lambda {
        good = Verification.verify_params!('update',
                           {a:'foo',b:'bar',signature:'badsig'})
      }.should raise_error(Recurly::ForgedQueryString)
    end

    it "should reject expired signature" do
      Time.stub!(:now).and_return(Time.at(origin_time+7200)) # two hours passed
      lambda {
        good = Verification.verify_params!('update',
                           {a:'foo',b:'bar',signature:test_sig})
      }.should raise_error(Recurly::ForgedQueryString)
    end

    it "should reject time traveling signatures from the future" do
      Time.stub!(:now).and_return(Time.at(origin_time-60)) # one minute earlier
      lambda {
        good = Verification.verify_params!('update',
                           {a:'foo',b:'bar',signature:test_sig})
      }.should raise_error(Recurly::ForgedQueryString)
    end
  end

end
