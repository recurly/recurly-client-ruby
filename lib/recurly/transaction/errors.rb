module Recurly
  class Transaction < Resource
    # The base error class for transaction errors, raised when a transaction
    # fails.
    #
    # Error messages are customer-friendly, though only {DeclinedError}
    # messages should be a part of the normal API flow (a {ConfigurationError},
    # for example, is a problem that a customer cannot solve and requires your
    # attention).
    #
    # If a record of the transaction was stored in Recurly, it will be
    # accessible via {Error#transaction}.
    #
    # @example
    #   begin
    #     subscription.save!
    #   rescue Recurly::Resource::Invalid => e
    #     # Display e.record.errors...
    #   rescue Recurly::Transaction::DeclinedError => e
    #     # Display e.message and/or subscription (and associated) errors...
    #   rescue Recurly::Transaction::RetryableError => e
    #     # You should be able to attempt to save this again later.
    #   rescue Recurly::Transaction::Error => e
    #     # Alert yourself of the issue (i.e., log e.transaction).
    #     # Display a generic error message.
    #   end
    class Error < API::UnprocessableEntity
      # @return [Transaction] The transaction as returned (or updated) by
      #   Recurly.
      attr_reader :transaction

      def initialize request, response, transaction
        super request, response
        update_transaction transaction
      end

      # @return [String] A customer-friendly error message.
      def to_s
        xml.text '/errors/transaction_error/customer_message'
      end

      # @return [String] The transaction error code.
      def transaction_error_code
        xml.text '/errors/transaction_error/error_code'
      end

      private

      def update_transaction transaction
        return unless transaction_xml = xml['/errors/transaction']

        @transaction = transaction
        transaction = Transaction.from_xml transaction_xml
        if @transaction.nil?
          @transaction = transaction
        else
          @transaction.instance_variable_get(:@attributes).update(
            transaction.attributes
          )
        end
        @transaction.persist!
      end
    end

    # Raised when a transaction fails for a temporary reason. The transaction
    # should be retried later.
    class RetryableError < Error
    end

    # Raised when a transaction fails due to a misconfiguration, e.g. if the
    # gateway hasn't been configured.
    class ConfigurationError < Error
    end

    # Raised when a transaction fails because the billing information was
    # invalid.
    class DeclinedError < Error
    end

    # Raised when the gateway believes this transaction to be a duplicate.
    class DuplicateError < DeclinedError
    end

    class << Error
      CATEGORY_MAP = Hash.new DeclinedError
      CATEGORY_MAP.update(
        'communication' => RetryableError,
        'configuration' => ConfigurationError,
        'duplicate'     => DuplicateError
      )

      def validate! exception, transaction
        return unless exception.is_a? API::UnprocessableEntity

        category = exception.send(:xml).text(
          '/errors/transaction_error/error_category'
        ) and raise CATEGORY_MAP[category].new(
          exception.request, exception.response, transaction
        )
      end
    end
  end
end
