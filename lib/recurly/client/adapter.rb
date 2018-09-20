require 'openssl'

module Recurly
  class Client
    module NetHttpPersistentAdapter
      protected
      def configure_net_adapter(faraday)
        faraday.adapter :net_http_persistent do |http|
          # yields Net::HTTP::Persistent
          http.keep_alive_timeout = 60
        end
      end
    end

    module NetHttpAdapter
      protected
      def configure_net_adapter(faraday)
        faraday.adapter :net_http do |http|
          # yields Net::HTTP
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
