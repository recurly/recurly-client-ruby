# HTTP Adapter Implementation Guide

The Recurly Ruby client separates the SDK concerns (URL/query building, auth
headers, `Idempotency-Key`, status → typed-error mapping, and the retry loop)
from the HTTP transport. The transport lives behind a small, injectable
**adapter** seam, so you can swap in your own HTTP layer without forking the SDK.

Common reasons to provide a custom adapter:

- **Observability** — wrap requests with tracing/metrics/logging.
- **Proxy / TLS** — route through a proxy or use a custom certificate store.
- **Testing** — stub the transport with canned responses.

By default the client uses `Recurly::HTTP::DefaultHttpAdapter` (backed by
`Net::HTTP`), and the default path behaves exactly as it did before the adapter
seam existed.

## The contract

An adapter is any object that responds to `#call`:

```ruby
# @param method       [String] a Recurly::HTTP::HttpMethod constant ("GET", "POST", ...)
# @param url          [String] the ABSOLUTE request url (scheme + host + path + query)
# @param headers      [Hash]   app-level request headers (plain Ruby Hash)
# @param body         [String, nil] serialized request body
# @param open_timeout [Numeric, nil] per-request connect timeout override (seconds)
# @param read_timeout [Numeric, nil] per-request read timeout override (seconds)
# @return [Recurly::HTTP::AdapterResponse]
# @raise  [Recurly::Errors::TransportError] on transport failure only
def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
end
```

You may subclass `Recurly::HTTP::Adapter` (which raises `NotImplementedError`
from `#call`) or simply duck-type `#call`.

### Return value: `AdapterResponse`

On any completed HTTP exchange — **including 4xx and 5xx** — return a
`Recurly::HTTP::AdapterResponse`:

```ruby
Recurly::HTTP::AdapterResponse.new(
  status_code:   200,                  # Integer
  headers:       { "content-type" => "application/json" }, # case-insensitive lookup
  body:          response_body_string, # String or nil
  reason_phrase: "OK",                 # String or nil
)
```

- `headers` lookup is **case-insensitive** (keys are downcased on construction).
- Do **not** raise for `4xx`/`5xx`. The SDK maps status codes to typed errors
  (`Recurly::Errors::*`) itself. Raising would bypass that mapping.
- `reason_phrase` may be `nil`; the SDK falls back to a vendored status → phrase
  table when needed.

### Errors: `TransportError`

Raise `Recurly::Errors::TransportError` **only** for genuine transport failures
(the request never produced an HTTP response — timeout, connection refused, SSL
handshake failure, DNS failure, etc.). Carry a `kind` so the SDK can reproduce
its historical typed-error mapping after retries are exhausted:

| `kind`        | SDK raises (after retries)                    |
|---------------|-----------------------------------------------|
| `:timeout`    | `Recurly::Errors::TimeoutError`               |
| `:connection` | `Recurly::Errors::ConnectionFailedError`      |
| `:ssl`        | `Recurly::Errors::SSLError`                    |
| `:network`    | `Recurly::Errors::NetworkError` (default)      |

```ruby
raise Recurly::Errors::TransportError.new(
  "Request timed out",
  kind: :timeout,       # defaults to :network if omitted
  cause: original_error, # optional underlying exception
)
```

Adapters that only ever set `:network` degrade gracefully to `NetworkError`.

### Compression / gzip

Compression is **optional**. The default `Net::HTTP` adapter auto-negotiates and
decompresses gzip, but the SDK does not require it — an adapter may return an
uncompressed body and everything still works. Do not hand-roll gzip.

## `DefaultHttpAdapter` configuration

`Recurly::HTTP::DefaultHttpAdapter` accepts:

| Option               | Default   | Meaning                                     |
|----------------------|-----------|---------------------------------------------|
| `connection_pool:`   | (required)| the shared `Recurly::ConnectionPool`        |
| `keep_alive_timeout:`| (required)| keep-alive timeout in seconds               |
| `ca_file:`           | `nil`     | CA bundle path                              |
| `timeout:`           | `60_000`  | read timeout in **milliseconds** (60s)      |
| `open_timeout:`      | `20_000`  | connect timeout in **milliseconds** (20s)   |
| `logger:`            | `nil`     | optional logger                             |

When you don't pass `http_adapter:`, the client builds a `DefaultHttpAdapter`
wired to the shared class-level `Recurly::Client.connection_pool`.

## Example: a recording adapter

```ruby
class RecordingAdapter < Recurly::HTTP::Adapter
  attr_reader :requests

  def initialize(inner)
    @inner = inner
    @requests = []
  end

  def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
    @requests << { method: method, url: url }
    started = Time.now
    response = @inner.call(method, url, headers, body,
                           open_timeout: open_timeout, read_timeout: read_timeout)
    puts "#{method} #{url} -> #{response.status_code} (#{Time.now - started}s)"
    response
  end
end

inner = Recurly::HTTP::DefaultHttpAdapter.new(
  connection_pool: Recurly::Client.connection_pool,
  keep_alive_timeout: 600,
  ca_file: Recurly::Client::CA_FILE,
)

client = Recurly::Client.new(api_key: API_KEY, http_adapter: RecordingAdapter.new(inner))
account = client.get_account(account_id: "code-benjamin-du-monde")
```

## Example: a fully custom adapter

```ruby
class MyAdapter < Recurly::HTTP::Adapter
  def call(method, url, headers, body, open_timeout: nil, read_timeout: nil)
    http_response = MyHttpLibrary.request(method, url, headers: headers, body: body)

    Recurly::HTTP::AdapterResponse.new(
      status_code:   http_response.status,
      headers:       http_response.headers,
      body:          http_response.body,
      reason_phrase: http_response.reason,
    )
  rescue MyHttpLibrary::TimeoutError => e
    raise Recurly::Errors::TransportError.new(e.message, kind: :timeout, cause: e)
  rescue MyHttpLibrary::ConnectionError => e
    raise Recurly::Errors::TransportError.new(e.message, kind: :connection, cause: e)
  end
end

client = Recurly::Client.new(api_key: API_KEY, http_adapter: MyAdapter.new)
```
