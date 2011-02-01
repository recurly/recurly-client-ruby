module Recurly

  module Action
    CreateSubscription = "create_subscription"
    UpdateBilling = "update_billing"
    CreateTransaction = "create_transaction"
  end

  class Transparent
    attr_accessor :data

    def initialize(data = {})
      @data = data || {}
    end

    # output the transparent data as a hidden field
    def hidden_field
      html = %{<input type="hidden" name="data" value="#{ERB::Util.html_escape(encoded_data)}" />}

      if html.respond_to?(:html_safe)
        html.html_safe
      else
        html
      end
    end

    # output transparent data along with a verification string to prevent tampering of data
    def encoded_data
      verify_required_fields

      # convert data to a query string
      query_data = self.class.query_string(data)

      # generate a validation string by encrypting the string using the private key
      validation_string = self.class.encrypt_string(query_data)

      # return the validation and query data
      "#{validation_string}|#{query_data}"
    end

    # verify that certain fields are present (or else the transparent post wont work)
    def verify_required_fields
      # make sure there's a redirect_url defined
      unless @data.has_key?(:redirect_url)
        raise "A :redirect_url key must be defined for Transparent posts"
      end

      return true
    end

    # convert data into query string
    def self.query_string(data = {})
      # process data
      data = process_data(data.dup)

      address = Addressable::URI.new
      address.query_values = data
      address.query
    end

    # returns the url to post to
    def self.url(action = nil)
      raise "Recurly gem not configured. run `rake recurly:setup`" unless Recurly.configured?

      # default action to create new subscription
      action ||= Action::CreateSubscription

      "#{Recurly.site}/transparent/#{action}"
    end

    # encode a string using the configured private key
    def self.encrypt_string(input_string)
      raise "Recurly not configured. To use transparent redirects, set your private_key within config/recurly.yml to the private_key provided by recurly.com" unless Recurly.private_key.present?
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