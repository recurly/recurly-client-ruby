# frozen_string_literal: true

require "net/https"

module Recurly
  class ConnectionPool
    def initialize
      @mutex = Mutex.new
      @pool = Hash.new { |h, k| h[k] = [] }
    end

    def with_connection(uri:, ca_file: nil)
      http = nil
      @mutex.synchronize do
        http = @pool[[uri.host, uri.port]].pop
      end

      # create connection if the pool was empty
      http ||= init_http_connection(uri, ca_file)

      response = yield http

      if http.started?
        @mutex.synchronize do
          @pool[[uri.host, uri.port]].push(http)
        end
      end

      response
    end

    def init_http_connection(uri, ca_file)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.ca_file = ca_file
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.keep_alive_timeout = 600

      http
    end
  end
end
