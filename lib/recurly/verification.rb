module Recurly
  module Verification
    class PreEscapedString < String
    end

    def digest_data(data) 
      if data.is_a? Array
        return nil if data.empty?
        PreEscapedString.new( '[%s]' % data.map{|v|digest_data(v)}.compact.join(',') )
      elsif data.is_a? Hash
        digest_data Hash[data.sort].map {|k,v|
          prefix = (k =~ /\A\d+\Z/) ? '' : (k.to_s+':')
          (v=digest_data(v)).nil? ? nil : PreEscapedString.new('%s%s' % [prefix,v])
        }
      elsif data.is_a?(String) && !data.instance_of?(PreEscapedString)
        PreEscapedString.new( data.gsub(/([\[\]\,\:\\])/) { |c| '\\' + c } )
      else
        data
      end
    end

    def generate_signature(claim, args, timestamp=nil)
      raise Recurly::ConfigurationError.new("Recurly gem not configured. 'private_key' missing.") if Recurly.private_key.blank?

      timestamp ||= Time.now.to_i
      timestamp = timestamp.to_s
      input_data = [timestamp,claim,args]
      input_string = digest_data(input_data)

      digest_key = ::Digest::SHA1.digest(Recurly.private_key)
      sha1_hash = ::OpenSSL::Digest::Digest.new("sha1")
      signature = ::OpenSSL::HMAC.hexdigest(sha1_hash, digest_key, input_string.to_s)
      signature + '-' + timestamp
    end

    # Raises a Recurly::ForgedQueryString exception if the signature cannot be validated
    def verify_params!(claim, args)
      args = Hash[args.map { |k, v| [k.to_s, v] }]
      signature = args.delete('signature') or raise Recurly::ForgedQueryString.new('Signature is missing')
      hmac, timestamp = signature.split('-')
      age = Time.now.to_i - timestamp.to_i
      raise Recurly::ForgedQueryString.new('Timestamp is too old or new') if age > 3600 || age < 0

      if signature != generate_signature(claim, args, timestamp)
        raise Recurly::ForgedQueryString.new('Signature cannot be verified')
      end
    end

    def sign_billing_info_update(account_code)
      generate_signature('billinginfoupdate', {
        account_code: account_code
      })
    end

    def sign_transaction(amount_in_cents, currency, account_code=nil)
      generate_signature('transactioncreate', {
        account_code: account_code,
        currency: currency,
        amount_in_cents: amount_in_cents
      }) 
    end

    def verify_subscription!(params)
      verify_params! 'subscriptioncreated', params
    end

    def verify_transaction!(params)
      verify_params! 'transactioncreated', params
    end

    def verify_billing_info_update!(params)
      verify_params! 'billinginfoupdated', params
    end

    extend self
  end
end
