module Recurly
  class Transparent

    # returns the url to post to
    def self.url
      raise "Recurly gem not configured. run `rake recurly:setup`" unless Recurly.configured?
      "#{Recurly.site}/transparent"
    end

    # return a verification string to prevent tampering of data
    def self.transport(data = {})
      # convert data to a query string
      query_data = self.query_string(data)

      # generate a validation string by encrypting the string using the private key
      validation_string = encrypt_string(query_data)

      # return the validation and query data
      "#{validation_string}|#{query_data}"
    end

    # convert data into query string
    def self.query_string(data = {})
      # process data
      data = process_data(data.dup)

      address = Addressable::URI.new
      address.query_values = data
      address.query
    end

    # encode a string using the configured private key
    def self.encrypt_string(input_string)
      digest_key = ::Digest::SHA1.digest(Recurly.private_key)
      sha1_hash = ::OpenSSL::Digest::Digest.new("sha1")
      ::OpenSSL::HMAC.hexdigest(sha1_hash, digest_key, input_string.to_s)
    end

    # recursively process the query data (running to_s on values)
    def self.process_data(data = {})
      data.each do |key, val|
        if val.is_a?(Hash)
          data[key] = process_data(val)
        elsif val.is_a?(Enumerable)
          data[key] = val.map{|i| i.to_s}
        else
          data[key] = val.to_s
        end
      end
    end
  end
end