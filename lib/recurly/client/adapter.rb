require "openssl"

module Recurly
  class Client
    module NetHttpPersistentAdapter
      protected

      def configure_net_adapter(faraday)
        faraday.adapter :net_http_persistent do |http|
          # yields Net::HTTP::Persistent
          # for net-http-persistent 2.X, alternative is for 3.X
          if http.respond_to? :keep_alive_timeout
            http.keep_alive_timeout = 60
          else
            http.keep_alive = 60
          end
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
      require "net/http/persistent"
      include NetHttpPersistentAdapter
    rescue LoadError
    end
  end
end
