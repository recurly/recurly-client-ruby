require 'spec_helper'

describe Transaction do
  describe ".find" do
    let(:transaction) do
      stub_api_request(
        :get, 'transactions/abcdef1234567890', 'transactions/show-200'
      )
      Transaction.find 'abcdef1234567890'
    end

    it "must return a transaction when available" do
      transaction.must_be_instance_of Transaction
    end

    it "must parse the fraud_info object if it exists" do
      transaction.fraud_info.must_be_instance_of Hash
      transaction.fraud_info["score"].must_equal 88
      transaction.fraud_info["decision"].must_equal "DECLINE"
    end
  end

  describe ".original_transaction" do
    it "must return a Transaction object" do
      stub_api_request(:get, 'transactions/abcdef1234567890', 'transactions/show-200')
      stub_api_request(:get, 'transactions/1234567890abcdef', 'transactions/show-200')

      transaction = Transaction.find 'abcdef1234567890'
      transaction.original_transaction.must_be_instance_of Transaction
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
      error.gateway_error_code.must_equal "123"
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
