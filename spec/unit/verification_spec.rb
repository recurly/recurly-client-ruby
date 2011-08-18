require 'spec_helper'

module Recurly
  describe Verification do
    origin_time = 1312806801
    test_sig = '55c24ea6a183382d82bba6b771bfb503ff25b92d-1312806801'

    before(:each) do
      Recurly.configure_from_yaml("#{File.dirname(__FILE__)}/../config/recurly.yml")
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
      good = Verification.verify_params('update',
                         {a:'foo',b:'bar',signature:test_sig})
      good.should == true
    end

    it "should reject invalid signature" do
      Time.stub!(:now).and_return(Time.at(origin_time+60)) # one minute passed
      good = Verification.verify_params('update',
                         {a:'foo',b:'bar',signature:'badsig'})
      good.should == false
    end

    it "should reject expired signature" do
      Time.stub!(:now).and_return(Time.at(origin_time+7200)) # two hours passed
      good = Verification.verify_params('update',
                         {a:'foo',b:'bar',signature:test_sig})
      good.should == false
    end

    it "should reject time traveling signatures from the future" do
      Time.stub!(:now).and_return(Time.at(origin_time-60)) # one minute earlier
      good = Verification.verify_params('update',
                         {a:'foo',b:'bar',signature:test_sig})
      good.should == false
    end
  end

end
