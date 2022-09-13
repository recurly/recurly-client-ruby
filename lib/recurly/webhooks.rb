module Recurly
  module Webhooks
    DEFAULT_TOLERANCE = 5 * 60 * 1000

    # Verify webhook signature
    #
    # @param header [String] recurly-signature header from request
    # @param secret [String] Shared secret for notification endpoint
    # @param body [String] Request POST body
    # @param tolerance [Integer] Allowed notification time drift in milliseconds
    # @example
    #   begin
    #     Recurly::Webhooks.verify_signature(header,
    #                                        ENV['WEBHOOKS_KEY'],
    #                                        request.body)
    #   rescue Recurly::Errors::SignatureVerificationError => e
    #     puts e.message
    #   end
    #
    def self.verify_signature(header, secret, body, tolerance: DEFAULT_TOLERANCE)
      s_timestamp, *signatures = header.split(",")
      timestamp = Integer(s_timestamp)
      now = (Time.now.to_f * 1000).to_i

      if (now - timestamp).abs > tolerance
        raise Recurly::Errors::SignatureVerificationError.new(
          "Notification (#{Time.at(timestamp / 1000.0)}) is more than #{tolerance / 1000.0}s out of date"
        )
      end

      expected = OpenSSL::HMAC.hexdigest("sha256", secret, "#{timestamp}.#{body}")

      unless signatures.any? { |s| secure_compare(expected, s) }
        raise Recurly::Errors::SignatureVerificationError.new(
          "No matching signatures found for payload"
        )
      end
    end

    # https://github.com/rack/rack/blob/2-2-stable/lib/rack/utils.rb#L374
    # https://github.com/heartcombo/devise/blob/4-1-stable/lib/devise.rb#L477
    def self.secure_compare(a, b)
      return false if a.bytesize != b.bytesize
      l = a.unpack("C#{a.bytesize}")

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end
    private_class_method :secure_compare
  end
end
