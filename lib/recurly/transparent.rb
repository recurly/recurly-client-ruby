module Recurly
  class Transparent

    # returns the url to post to
    def self.url
      raise "Recurly gem not configured. run `rake recurly:setup`" unless Recurly.configured?
      "#{Recurly.site}/transparent"
    end
    
    # encode a string using the configured private key
    def self.encrypt_data(data)
      digest_key = ::Digest::SHA1.digest(Recurly.private_key)
      sha1_hash = ::OpenSSL::Digest::Digest.new("sha1")
      ::OpenSSL::HMAC.hexdigest(sha1_hash, digest_key, data.to_s)
    end
  end  
end