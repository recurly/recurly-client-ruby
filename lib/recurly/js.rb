require 'openssl'
require 'base64'
require 'cgi'

module Recurly
  # A collection of helper methods to use to verify
  # {Recurly.js}[http://js.recurly.com/] callbacks.
  module JS
    # Raised when signature verification fails.
    class RequestForgery < Error
    end

    # Raised when the timestamp is over an hour old. Prevents replay attacks.
    class RequestTooOld < RequestForgery
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

      # @return [String] A public key for Recurly.js.
      # @raise [ConfigurationError] No public key has been set.
      def public_key
        defined? @public_key and @public_key or raise(
          ConfigurationError, "public_key not configured"
        )
      end
      attr_writer :public_key

      # Create a signature for a given hash for Recurly.js
      # @param Array of objects and hash of data to sign
      def sign *records
        data = records.last.is_a?(Hash) ? records.pop.dup : {}
        records.each do |record|
          data[record.class.member_name] = record.signable_attributes
        end
        Helper.stringify_keys! data
        data['timestamp'] ||= Time.now.to_i
        data['nonce'] ||= Base64.encode64(
          OpenSSL::Random.random_bytes(32)
        ).gsub(/\W/, '')
        unsigned = to_query data
        signed = OpenSSL::HMAC.hexdigest 'sha1', private_key, unsigned
        signature = [signed, unsigned].join '|'
        signature = signature.html_safe if signature.respond_to? :html_safe
        signature
      end

      # Fetches a record using a token provided by Recurly.js.
      # @param [String] Token to look up
      # @return [BillingInfo, Invoice, Subscription] The record created or
      #   modified by Recurly.js
      # @raise [API::NotFound] No record was found for the token provided.
      # @example
      #   begin
      #     Recurly.js.fetch params[:token]
      #   rescue Recurly::API::NotFound
      #     # Handle potential tampering here.
      #   end
      def fetch token
        Resource.from_response API.get "recurly_js/result/#{token}"
      end

      # @return [String]
      def inspect
        'Recurly.js'
      end

      private

      def to_query object, key = nil
        case object
        when Hash
          object.map { |k, v| to_query v, key ? "#{key}[#{k}]" : k }.sort * '&'
        when Array
          object.map { |o| to_query o, "#{key}[]" } * '&'
        else
          "#{CGI.escape key.to_s}=#{CGI.escape object.to_s}"
        end
      end
    end
  end
end
