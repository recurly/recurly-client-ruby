require 'spec_helper'

describe Transaction do
  describe ".find" do
    it "must return a transaction when available" do
      stub_api_request(
        :get, 'transactions/abcdef1234567890', 'transactions/show-200'
      )
      transaction = Transaction.find 'abcdef1234567890'
      transaction.must_be_instance_of Transaction
    end
  end

  describe "#save" do
    it "must re-raise a transaction error" do
      stub_api_request :post, 'transactions', 'transaction_error'
      transaction = Transaction.new :account => {
        :account_code => 'test',
        :billing_info => {
          :credit_card_number => '4111111111111111'
        }
      }
      error = proc { transaction.save }.must_raise Transaction::DeclinedError
      error.message.must_equal(
        "Your card number is not valid. Please update your card number."
      )
      transaction.account.billing_info.errors[:credit_card_number].wont_be_nil
      error.transaction_error_code.must_equal 'invalid_card_number'
      error.transaction.must_equal transaction
      transaction.persisted?.must_equal true
    end

    it "won't save a persisted transaction" do
      transaction = Transaction.new
      transaction.persist!
      proc { transaction.save }.must_raise Error
    end
  end
end
