require "net/https"

module Recurly
  class ConnectionPool
    def initialize
      @mutex = Mutex.new
      @pool = []
    end

    def with_connection
      http = nil
      @mutex.synchronize do
        http = @pool.pop
      end

      # create connection if the pool was empty
      http ||= init_http_connection

      response = yield http

      if http.started?
        @mutex.synchronize do
          @pool.push(http)
        end
      end

      response
    end

    def init_http_connection
      http = Net::HTTP.new(Client::BASE_HOST, Client::BASE_PORT)
      http.use_ssl = true
      http.ca_file = Client::CA_FILE
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.keep_alive_timeout = 600

      http
    end
  end
end
