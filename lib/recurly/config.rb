# frozen_string_literal: true

module Recurly
  # Configuration class for Recurly API client.
  class Config
    @@client = nil

    def self.client=(val)
      @@client = val
    end

    def self.api_key
      ENV["RECURLY_API_KEY"]
    end

    def self.host
      ENV["RECURLY_HOST"] || "v3.recurly.com"
    end

    def self.port
      ENV["RECURLY_PORT"] || "443"
    end

    def self.region
      ENV["RECURLY_REGION"]&.to_sym || :us
    end

    def self.debug?
      ENV["RECURLY_DEBUG"].to_s.upcase == "TRUE"
    end

    def self.base_url
      "https://#{host}:#{port}"
    end

    def self.ca_file
      return unless host.end_with?(".recurly.dev")

      @ca_file ||= begin
          path = File.join(File.dirname(__FILE__), "../../../../", "certs/ca_root.crt")
          File.exist?(path) ? path : (raise "CA file does not exist: #{path}")
        end
    end

    def self.client
      return @@client if @@client

      opt = {
        api_key: api_key,
        logger: Logger.new(STDOUT).tap { |l| l.level = debug? ? Logger::DEBUG : Logger::INFO },
        region: region,
        base_url: base_url,
      }
      opt[:ca_file] = ca_file if ca_file
      @client ||= Recurly::Client.new(**opt)
    end
  end
end
