# Recurly

[![Rubygems](https://img.shields.io/static/v1?label=rubygems&message=recurly&color=purple)](https://rubygems.org/gems/recurly)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

This repository houses the official ruby client for Recurly's V3 API.

> *Note*:
> If you were looking for the V2 client, see the [v2 branch](https://github.com/recurly/recurly-client-ruby/tree/v2).

## Reference Documentation

Getting Started Guide and reference documentation can be found on [Github Pages](https://recurly.github.io/recurly-client-ruby/).

## Custom HTTP Adapter

The client ships with a default `Net::HTTP`-backed transport, but you can inject
your own HTTP layer (for observability, proxy/TLS control, or transport mocking)
by passing an adapter that responds to `#call`:

```ruby
client = Recurly::Client.new(api_key: API_KEY, http_adapter: MyAdapter.new)
```

An adapter must implement:

```ruby
# @return [Recurly::HTTP::AdapterResponse]
# @raise  [Recurly::Errors::TransportError] on transport-level failure only
def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
end
```

- `method` is a `Recurly::HTTP::HttpMethod` string (`"GET"`, `"POST"`, ...).
- `url` is an **absolute** URL (scheme + host + path + query).
- `headers` is a plain `Hash` of app-level headers (the SDK owns `Authorization`,
  `Idempotency-Key`, `Content-Type`, etc.).
- `body` is a serialized `String` or `nil`.
- HTTP `4xx`/`5xx` responses must be **returned** as an `AdapterResponse`, never
  raised. Only genuine transport failures raise `Recurly::Errors::TransportError`.

## Contributing

Please see our [Contributing Guide](CONTRIBUTING.md).
