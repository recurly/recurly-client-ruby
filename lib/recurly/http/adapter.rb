module Recurly
  module HTTP
    # Base class documenting the HTTP adapter contract. Custom adapters should
    # subclass this (or simply respond to +#call+) and implement +#call+.
    #
    # Contract:
    # - +#call(method, url, headers, body, open_timeout: nil, read_timeout: nil)+
    #   performs the HTTP request. +method+ is a {HttpMethod} string, +url+ is an
    #   ABSOLUTE url (scheme+host+path+query), +headers+ is a plain Hash of
    #   app-level headers, and +body+ is a serialized String or nil.
    # - On success (including HTTP 4xx and 5xx) it MUST return a
    #   {Recurly::HTTP::AdapterResponse}. 4xx/5xx are RETURNED, never raised.
    # - On a transport-level failure (timeout, connection refused, SSL error,
    #   etc.) it MUST raise {Recurly::Errors::TransportError}, ideally carrying a
    #   +kind+ so the client can reproduce its typed-error mapping.
    class Adapter
      def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
        raise NotImplementedError, "#{self.class} must implement #call"
      end
    end
  end
end
