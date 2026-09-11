module Recurly
  module HTTP
    # The normalized response object every HTTP adapter must return from +#call+.
    # It decouples the client from any particular transport library
    # (+Net::HTTP+, Faraday, Typhoeus, ...).
    #
    # Header lookup is case-insensitive: keys are downcased on construction and
    # +#[]+ downcases the lookup key.
    class AdapterResponse
      # @return [Integer] the numeric HTTP status code (e.g. 200)
      attr_reader :status_code

      # @return [Hash] response headers, keyed by downcased name
      attr_reader :headers

      # @return [String, nil] the raw response body
      attr_reader :body

      # @return [String, nil] the HTTP reason phrase (e.g. "Bad Gateway"), if the
      #   adapter captured one. May be nil for adapters that do not surface it.
      attr_reader :reason_phrase

      def initialize(status_code:, headers:, body:, reason_phrase: nil)
        @status_code = status_code
        @headers = (headers || {}).each_with_object({}) do |(k, v), acc|
          acc[k.to_s.downcase] = v
        end
        @body = body
        @reason_phrase = reason_phrase
      end

      # Case-insensitive header lookup.
      # @param name [String]
      # @return [String, nil]
      def [](name)
        @headers[name.to_s.downcase]
      end

      # The status code as a String. +Errors::APIError.from_response+ looks up
      # the string status, so the object handed to it must expose a string
      # +#code+.
      # @return [String]
      def code
        @status_code.to_s
      end
    end
  end
end
