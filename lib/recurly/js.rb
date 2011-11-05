require 'openssl'

module Recurly
  # A collection of helper methods to use to verify
  # {Recurly.js}[http://js.recurly.com/] callbacks.
  module JS
    # Raised when signature verification fails.
    class RequestForgery < Error
    end

    # Used to prevent strings from being escaped during digest.
    class SafeString < String
    end

    class << self
      # @return [String] A private key for Recurly.js.
      # @raise [ConfigurationError] No private key has been set.
      def private_key
        defined? @private_key and @private_key or raise(
          ConfigurationError, "private_key not configured"
        )
      end
      attr_writer :private_key

      # @return [String]
      def sign_billing_info account_code
        sign 'billinginfoupdate', 'account_code' => account_code
      end

      # @return [String]
      def sign_transaction amount_in_cents, currency = nil, account_code = nil
        sign 'transactioncreate', {
          'amount_in_cents' => amount_in_cents,
          'currency'        => currency || Recurly.default_currency,
          'account_code'    => account_code
        }
      end

      # @return [true]
      # @raise [RequestForgery] If verification fails.
      def verify_billing_info! params
        verify! 'billinginfoupdated', params.select { |k, v| ['signature', 'account_code'].include?(k) }
      end

      # @return [true]
      # @raise [RequestForgery] If verification fails.
      def verify_transaction! params
        verify! 'subscriptioncreated', params.select { |k, v| ['signature', 'account_code', 'amount_in_cents', 'currency', 'uuid'].include?(k) }
      end

      # @return [true]
      # @raise [RequestForgery] If verification fails.
      def verify_subscription! params
        verify! 'subscriptioncreated', params.select { |k, v| ['quantity', 'signature', 'account_code', 'plan_code', 'add_on_codes', 'coupon_code'].include?(k) }
      end

      # @return [String]
      def inspect
        'Recurly.js'
      end

      private

      def sign claim, params, timestamp = Time.now
        signature = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest::Digest.new('SHA1'),
          Digest::SHA1.digest(private_key),
          digest([timestamp = timestamp.to_i, claim, params])
        )
        "#{signature}-#{timestamp}"
      end

      def verify! claim, params
        params = Hash[params.map { |key, value| [key.to_s, value] }]
        signature = params.delete('signature') or raise(
          RequestForgery, 'missing signature'
        )
        timestamp = signature.split('-').last
        age = Time.now.to_i - timestamp.to_i
        unless (-3600..3600).include? age
          raise RequestForgery, 'stale timestamp'
        end

        if signature != sign(claim, params, timestamp)
          raise RequestForgery,
            "signature can't be verified (invalid request or private key)"
        end

        true
      end

      def digest data
        case data
        when Array
          return if data.empty?
          SafeString.new "[#{data.map { |d| digest d }.compact.join ','}]"
        when Hash
          data = Hash[data.map { |key, value| [key.to_s, value] }]
          digest data.keys.sort.map { |key|
            next unless value = digest(data[key])
            SafeString.new "#{"#{key}:" unless key =~ /^\d+$/}#{value}"
          }
        when SafeString
          data
        when String
          SafeString.new data.gsub(/([\[\]\,\:\\])/, '\\\\\1')
        else
          data
        end
      end
    end
  end
end
