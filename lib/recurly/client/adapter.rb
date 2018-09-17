require 'openssl'

module Recurly
  class Client
    module NetHttpPersistentAdapter
      protected
      def configure_net_adapter(faraday)
        faraday.adapter :net_http_persistent do |http| # yields Net::HTTP
          # Let's not use the bundled cert in production yet
          # but we will use these certs for any other staging or dev environment
          unless BASE_URL.end_with?('.recurly.com')
            http.ca_file = File.join(File.dirname(__FILE__), '../data/ca-certificates.crt')
          end
          http.open_timeout = 50
          http.read_timeout = 60
        end
      end
    end

    module NetHttpAdapter
      protected
      def configure_net_adapter(faraday)
        faraday.adapter :net_http do |http| # yields Net::HTTP
          # Let's not use the bundled cert in production yet
          # but we will use these certs for any other staging or dev environment
          unless BASE_URL.end_with?('.recurly.com')
            http.ca_file = File.join(File.dirname(__FILE__), '../data/ca-certificates.crt')
          end
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.open_timeout = 50
          http.read_timeout = 60
          http.keep_alive_timeout = 60
        end
      end
    end

    include NetHttpAdapter

    begin
      require 'net/http/persistent'
      include NetHttpPersistentAdapter
    rescue LoadError
    end
  end
end
