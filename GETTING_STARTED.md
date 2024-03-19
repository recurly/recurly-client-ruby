This repository houses the official ruby client for Recurly's V3 API.

# Installing

In your Gemfile, add `recurly` as a dependency.

```ruby
gem 'recurly', '~> 4.48'
```

> *Note*: We try to follow [semantic versioning](https://semver.org/) and will only apply breaking changes to major versions.

# Creating a client

A client represents a connection to the Recurly servers. Every call
to the server exists as a method on this class. To initialize, you only need the private API key
which can be obtained on the [API Credentials Page](https://app.recurly.com/go/integrations/api_keys).

```ruby
API_KEY = '83749879bbde395b5fe0cc1a5abf8e5'
client = Recurly::Client.new(api_key: API_KEY)
sub = client.get_subscription(subscription_id: 'abcd123456')
```

To access Recurly API in Europe, you will need to specify the EU Region in the argument region.

```ruby
API_KEY = '83749879bbde395b5fe0cc1a5abf8e5'
client = Recurly::Client.new(api_key: API_KEY, region: :eu)
sub = client.get_subscription(subscription_id: 'abcd123456')
```

You can also pass the initializer a block. This will give you a client scoped for just that block:

```ruby
Recurly::Client.new(api_key: API_KEY) do |client|
  sub = client.get_subscription(subscription_id: 'abcd123456')
end
```

If you plan on using the client for more than one site, you should initialize a new client for each site.

```ruby
client = Recurly::Client.new(api_key: API_KEY1) 
sub = client.get_subscription(subscription_id: 'abcd123456')

# you should create a new client to connect to another site
client = Recurly::Client.new(api_key: API_KEY2) 
sub = client.get_subscription(subscription_id: 'abcd7890')
```

## Logging

The client constructor optionally accepts a logger provided by the programmer. The logger you pass should be an instance of ruby stdlib's [Logger](https://ruby-doc.org/stdlib/libdoc/logger/rdoc/Logger.html)
or follow the same interface. By default, the client creates a logger to `STDOUT` with level `WARN`.

```ruby
require 'logger'

# Create a logger to STDOUT
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

# You could also use an existing logger
# If you are using Rails you may want to use your application's logger
logger = Rails.logger

client = Recurly::Client.new(api_key: API_KEY, logger: logger)
```

> *SECURITY WARNING*: The log level should never be set to DEBUG in production. This could potentially result in sensitive data in your logging system.

# Operations

The {Recurly::Client} contains every `operation` you can perform on the site as a list of methods. Each method is documented explaining
the types and descriptions for each input and return type. You can view all available operations by looking at the `Instance Methods Summary` list
on the {Recurly::Client} documentation page. Clicking a method will give you detailed information about its inputs and returns. Take the `create_account`
operation as an example: {Recurly::Client#create_account}.

# Pagination

Pagination is done by the class {Recurly::Pager}. All `list_*` methods on the client return an instance of this class.
The pager has an `each` method which accepts a block for each object in the entire list. Each page is fetched automatically
for you presenting the elements as a single enumerable.

```ruby
plans = client.list_plans()
plans.each do |plan|
  puts "Plan: #{plan.id}"
end
```

You may also paginate in chunks with `each_page`.

```ruby
plans = client.list_plans()
plans.each_page do |data|
  data.each do |plan|
    puts "Plan: #{plan.id}"
  end
end
```

Both {Pager#each} and {Pager#each_page} return Enumerators if a block is not given. This allows you to use other Enumerator methods
such as `map` or `each_with_index`.

```ruby
plans = client.list_plans()
plans.each_page.each_with_index do |data, page_num|
  puts "Page Number #{page_num}"
  data.each do |plan|
    puts "Plan: #{plan.id}"
  end
end
```

Pagination endpoints take a number of options to sort and filter the results. They can be passed in as a hash provided by the `:params` keyword argument.
The names, types, and descriptions of these arguments are listed in the rubydocs for each method:

```ruby
options = {
  params: {
    limit: 200, # number of items per page
    state: :active, # only active plans
    sort: :updated_at,
    order: :asc,
    begin_time: DateTime.new(2017,1,1), # January 1st 2017,
    end_time: DateTime.now
  }
}

plans = client.list_plans(**options)
plans.each do |plan|
  puts "Plan: #{plan.id}"
end
```

**A note on `limit`**:

`limit` defaults to 20 items per page and can be set from 1 to 200. Choosing a lower limit means more network requests but smaller payloads.
We recommend keeping the default for most cases but increasing the limit if you are planning on iterating through many pages of items (e.g. all transactions in your site).

## Efficiently Fetch the First or Last Resource

The Pager class implements a first method which allows you to fetch just the first or last resource from the server. On top of being a convenient abstraction, this is implemented efficiently by only asking the server for the 1 item you want.

```ruby
accounts = client.list_accounts(
  subscriber: true,
  order: :desc
)

last_subscriber = accounts.first
```

If you want to fetch the last account in this scenario, invert the order from descending `desc` to ascending `asc`:

```ruby
accounts = client.list_accounts(
  subscriber: true,
  order: :asc
)

first_subscriber = accounts.first
```

## Counting Resources

The Pager class implements a `count` method which allows you to count the resources the pager would return. It does so by calling the endpoint with `HEAD` and parsing and returning the `Recurly-Total-Records` header. This method respects any filtering parameters you apply to the pager, but the sorting parameters will have no effect.

```ruby
accounts = client.list_accounts(
  subscriber: true,
  begin_time: DateTime.new(2017,1,1)
)

# Calling count here will return an integer indicating
# the number of subscribers since 2017
count = accounts.count
# => 573
```

# Creating Resources

Currently, resources are created by passing in a `body` keyword argument in the form of a `Hash`.
This Hash must follow the schema of the documented request type. For example, the `create_plan` operation
takes a request of type {Recurly::Requests::PlanCreate}. Failing to conform to this schema will result in an argument
error.

```ruby
require 'securerandom'

code = SecureRandom.uuid
plan_data = {
  code: code,
  interval_length: 1,
  interval_unit: 'months',
  name: code,
  currencies: [
    {
      currency: 'USD',
      setup_fee: 800,
      unit_amount: 10
    }
  ]
}

plan = client.create_plan(body: plan_data)
```

# Error Handling

All errors thrown by this library are based off of the `Recurly::Errors::APIError`. There 

This library throws one main type of exception, `Recurly::Errors::APIError`. There exists an additional hierarchy of errors to facilitate the process of rescuing various classes of errors. More detail can be found in the [Api Errors Module](./lib/recurly/errors/api_errors.rb).

You can catch specific or generic versions of these exceptions. Example:

```ruby
begin
  client = Recurly::Client.new(api_key: API_KEY)
  code = "iexistalready"
  plan_data = {
    code: code,
    interval_length: 1,
    interval_unit: 'months',
    name: code,
    currencies: [
      {
        currency: 'USD',
        setup_fee: 800,
        unit_amount: 10
      }
    ]
  }

  plan = client.create_plan(body: plan_data)
rescue Recurly::Errors::ValidationError => ex
  puts ex.inspect
  #=> #<Recurly::ValidationError: Recurly::ValidationError: Code 'iexistalready' already exists>
  puts ex.recurly_error.inspect
  #=> #<Recurly::Error:0x007fbbdf8a32c8 @attributes={:type=>"validation", :message=>"Code 'iexistalready' already exists", :params=>[{"param"=>"code", "message"=>"'iexistalready' already exists"}]}>
  puts ex.status_code
  #=> 422
rescue Recurly::Errors::TimeoutError => ex
  # catch a specific server error
rescue Recurly::Errors::ServerError => ex
  # catch a generic server error
rescue Recurly::Errors::APIError => ex
  # catch a generic api error
end
```

`Recurly::Errors::APIError` instances provide access to the response via the `#get_response` method.

# HTTP Metadata

Sometimes you might want to get some additional information about the underlying HTTP request and response. Instead of
returning this information directly and forcing the programmer to unwrap it, we inject this metadata into the top level
resource that was returned. You can access the {Recurly::HTTP::Response} by calling `#get_response` on any {Recurly::Resource}.

**Warning**: Do not log or render whole requests or responses as they may contain PII or sensitive data.

```ruby
account = @client.get_account(account_id: "code-benjamin")
response = account.get_response
response.rate_limit_remaining #=> 1985
response.request_id #=> "0av50sm5l2n2gkf88ehg"
response.request.path #=> "/sites/subdomain-mysite/accounts/code-benjamin"
response.request.body #=> None
```

This also works on {Recurly::Resources::Empty} responses:

```ruby
response = @client.remove_line_item(
  line_item_id: "a959576b2b10b012"
).get_response
```
And it can be captured on exceptions through the {Recurly::APIError} object:

```ruby
begin
  account = client.get_account(account_id: "code-benjamin")
rescue Recurly::Errors::NotFoundError => e
  response = e.get_response()
  puts "Give this request id to Recurly Support: #{response.request_id}"
end
```

# Webhooks

Recurly can send webhooks to any publicly accessible server.
When an event in Recurly triggers a webhook (e.g., an account is opened),
Recurly will attempt to send this notification to the endpoint(s) you specify.
You can specify up to 10 endpoints through the application. All notifications will
be sent to all configured endpoints for your site. 

See our [product docs](https://docs.recurly.com/docs/webhooks) to learn more about webhooks
and see our [dev docs](https://developers.recurly.com/pages/webhooks.html) to learn about what payloads
are available.

Although our API is now JSON, our webhook payloads are still formatted as XML for the time being.
This library is not yet responsible for handling webhooks. If you do need webhooks, we recommend using a simple
XML to Hash parser.

If you are using Rails, we'd recommend [Hash.from_xml](https://apidock.com/rails/Hash/from_xml/class).

```ruby
notification = Hash.from_xml <<-XML
  <?xml version="1.0" encoding="UTF-8"?>
  <new_account_notification>
    <account>
      <account_code>1</account_code>
      <username nil="true"></username>
      <email>verena@example.com</email>
      <first_name>Verena</first_name>
      <last_name>Example</last_name>
      <company_name nil="true"></company_name>
    </account>
  </new_account_notification>
XML

code = notification["new_account_notification"]["account"]["account_code"]
puts "New Account with code #{code} created."
```

If you are not using Rails, we recommend you use [nokogiri](https://nokogiri.org/); however, heed security warnings
about parse options. Although the XML should only be coming from Recurly, you should parse it as untrusted to be safe.
Read more about the security implications of parsing untrusted XML in [this OWASP cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/XML_Security_Cheat_Sheet.html).
