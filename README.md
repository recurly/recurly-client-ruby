# Recurly

This gem is the ruby client to the v3, aka API next, aka PAPI, version of Recurly's API. Parts of this gem are generated
by the `recurly-client-gen` project.

## Getting Started

Read this before starting to get an overview of how to use this library.

### Creating a client

Client instances are now explicitly created and managed as opposed to the previous approach of opaque, statically
initialized clients. This makes multithreaded environments a lot easier and also provides one place where every
operation on recurly can be found (rather than having them spread out amongst classes).

`Recurly::Client#new` initializes a new client. It requires an API key:

```ruby
API_KEY = '83749879bbde395b5fe0cc1a5abf8e5'
SITE_ID = 'dqzlv9shi7wa'
client = Recurly::Client.new(api_key: API_KEY)
sub = client.get_subscription(site_id: SITE_ID, subscription_id: 'abcd123456')
```
You can also pass the initializer a block. This will give you a client scoped for just that block:

```ruby
Recurly::Client.new(api_key: API_KEY) do |client|
  sub = client.get_subscription(site_id: SITE_ID, subscription_id: 'abcd123456')
end
```

If you only plan on using the client for one site, you may pass in a `site_id` or a `subdomain` to the initializer.
This makes all `site_id` parameters optional.

```ruby
# Give a `site_id`
client = Recurly::Client.new(api_key: API_KEY, site_id: SITE_ID)

# Or use the subdomain
client = Recurly::Client.new(api_key: API_KEY, subdomain: 'mysite-dev') 

# You no longer need to provide `site_id` to these methods
sub = client.get_subscription(subscription_id: 'abcd123456')
```

### Operations

The {Recurly::Client} contains every `operation` you can perform on the site as a list of methods. Each method is documented explaining
the types and descriptions for each input and return type. You can view all available operations by looking at the `Instance Methods Summary` list
on the {Recurly::Client} documentation page. Clicking a method will give you detailed information about its inputs and returns. Take the `create_account`
operation as an example: {Recurly::Client#create_account}.

### Pagination

Pagination is done by the class `Recurly::Pager`. All `list_*` methods on the client return an instance of this class.
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

Both `Pager#each` and `Pager#each_page` return Enumerators if a block is not given. This allows you to use other Enumerator methods
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

Pagination endpoints take a number of options to sort and filter the results. They can be passed in as keyword arguments.
The names, types, and descriptions of these arguments are listed in the rubydocs for each method:

```ruby
options = {
  state: :active, # only active plans
  sort: :updated_at,
  order: :asc,
  begin_time: DateTime.new(2017,1,1), # January 1st 2017,
  end_time: DateTime.now
}

plans = client.list_plans(**options)
plans.each do |plan|
  puts "Plan: #{plan.id}"
end
```

### Creating Resources

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

### Error Handling

This library currently throws 2 types of exceptions. {Recurly::Errors::APIError} and {Recurly::Errors::NetworkError}. See these 2 files for the types of exceptions you can catch:

1. [API Errors](./lib/recurly/errors/api_errors.rb)
2. [Network Errors](./lib/recurly/errors/network_errors.rb)

You will normally be working with {Recurly::Errors::APIError}. You can catch specific or generic versions of these exceptions. Example:

```ruby
begin
  client = Recurly::Client.new(site_id: SITE_ID, api_key: API_KEY)
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
rescue Recurly::Errors::APIError => ex
  # catch a generic api error
rescue Recurly::Errors::TimeoutError => ex
  # catch a specific network error
rescue Recurly::Errors::NetworkError => ex
  # catch a generic network error
end
```
