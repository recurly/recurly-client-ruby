# A test double implementing the HTTP adapter contract. It records every
# `#call` invocation (method, url, headers, body) and returns canned
# AdapterResponses. Queue multiple responses to exercise the retry paths.
class MockHttpAdapter < Recurly::HTTP::Adapter
  Call = Struct.new(:method, :url, :headers, :body, :open_timeout, :read_timeout)

  attr_reader :calls

  # @param responses [Array] a response, an exception, or an array of them to
  #   return/raise in order. The last entry is reused once exhausted.
  def initialize(responses)
    @responses = Array(responses)
    @calls = []
    @index = 0
  end

  def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
    @calls << Call.new(method, url, headers, body, open_timeout, read_timeout)
    result = @responses[[@index, @responses.length - 1].min]
    @index += 1
    raise result if result.is_a?(Exception)

    result
  end

  # Convenience builder for a canned AdapterResponse.
  def self.response(status_code:, body: "", headers: nil, reason_phrase: nil)
    Recurly::HTTP::AdapterResponse.new(
      status_code: status_code,
      headers: headers || { "content-type" => "application/json; charset=utf-8" },
      body: body,
      reason_phrase: reason_phrase,
    )
  end
end
