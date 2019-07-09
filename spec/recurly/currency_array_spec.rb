require "spec_helper"

RSpec.describe Recurly::CurrencyArray do
  subject do
    Recurly::CurrencyArray.new([
      Recurly::Resources::MyPricing.new(currency: "USD", amount: 123),
      Recurly::Resources::MyPricing.new(currency: "EUR", amount: 456),
    ])
  end

  it "is a normal Array" do
    expect(subject).to be_a Array
    expect(subject.length).to eq 2
  end

  it "can be indexed by currency" do
    expect(subject[:usd].amount).to eq 123
    expect(subject[:USD].amount).to eq 123
    expect(subject["USD"].amount).to eq 123
    expect(subject[:eur].amount).to eq 456
    expect(subject[:EUR].amount).to eq 456
    expect(subject["EUR"].amount).to eq 456
  end
end
