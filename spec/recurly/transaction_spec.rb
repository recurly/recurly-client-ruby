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
      customer_message = "Your card number is not valid. Please update your card number."
      error_code = 'invalid_card_number'
      stub_api_request :post, 'transactions', 'transaction_error'
      transaction = Transaction.new :account => {
        :account_code => 'test',
        :billing_info => {
          :credit_card_number => '4111111111111111'
        }
      }
      error = proc { transaction.save }.must_raise Transaction::DeclinedError
      error.message.must_equal customer_message
      transaction.account.billing_info.errors[:credit_card_number].wont_be_nil
      error.transaction_error_code.must_equal error_code
      error.transaction.must_equal transaction
      error.error_code.must_equal error_code
      error.error_category.must_equal "hard"
      error.merchant_message.must_equal "The credit card number is not valid. The customer needs to try a different number."
      error.customer_message.must_equal customer_message
      transaction.persisted?.must_equal true
    end

    it "won't save a persisted transaction" do
      transaction = Transaction.new
      transaction.persist!
      proc { transaction.save }.must_raise Error
    end
  end
end
