require 'spec_helper'

describe Money do
  describe "#initialize" do
    it "must instantiate with a hash representing currencies" do
      money = Money.new :USD => 5_00, :EUR => 3_00
      money.must_be_instance_of Money
      money[:USD].must_equal 5_00
      money[:EUR].must_equal 3_00
    end

    it "must instantiate with an integer representing a default currency" do
      Recurly.default_currency = 'USD'
      money = Money.new 1_00
      money.must_be_instance_of Money
      money[:USD].must_equal 1_00
    end
  end

  describe "#to_i" do
    it "must return money in cents unless multicurrency" do
      Money.new(1).to_i.must_equal 1
      proc { Money.new(:USD => 1, :EUR => 2).to_i }.must_raise TypeError
    end
  end
end
