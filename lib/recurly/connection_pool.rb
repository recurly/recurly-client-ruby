require "net/https"

module Recurly
  class ConnectionPool
    def initialize
      @mutex = Mutex.new
      @pool = []
    end

    def with_connection
      # just create and tear down a new connection every time
      # unless connection pooling is enabled
      unless Recurly.connection_pool_enabled?
        http = init_http_connection(keep_alive: false)
        return http.start { yield http }
      end

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

    def init_http_connection(keep_alive: true)
      host = "#{Recurly.subdomain}.recurly.com"
      http = Net::HTTP.new(host, 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      if keep_alive
        http.keep_alive_timeout = 600
      end

      http
    end
  end
end
