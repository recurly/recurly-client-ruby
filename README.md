Recurly Ruby Client
===================

The Recurly Ruby Client library is an open source library to interact with Recurly's subscription management from your Ruby on Rails website. The library interacts with Recurly's [REST API](http://support.recurly.com/api/basics).


Usage
-----

Please see the [documentation](http://support.recurly.com/faqs/api/ruby-client) and
[support forums](http://support.recurly.com/discussions) for more information. The [API Documentation](http://docs.recurly.com/api/basics) has numerous examples demonstrating how to use the Recurly Ruby client library.


Installation
------------

    gem 'recurly', '~> 0.4'


Configuration
-------------

The Recurly Ruby Client requires an API user to connect. Please see the [Authentication](http://docs.recurly.com/api/authentication/) documentation for more information.

In a YAML file at 'config/recurly.yml':

    production:
      api_key: your_api_key
      private_key: your_private_key
      subdomain: your_recurly_subdomain

    development:
      api_key: your_api_key
      private_key: your_private_key
      subdomain: your_recurly_subdomain

The environment is optional. If you're using the same account with development and production, it can be simplified to:

    api_key: your_api_key
    private_key: your_private_key
    subdomain: your_recurly_subdomain

Or, you may configure the Recurly gem using a `configure` block in 'config/initializers/recurly.rb':

    Recurly.configure do |c|
      c.api_key = 'your_api_key'
      c.private_key = 'your_private_key'
      c.subdomain = 'your-recurly-subdomain'
    end

**Please Note:** the setup parameters changed in version 0.4.0. Additional configuration options were also added for the [Transparent Post API](http://docs.recurly.com/transparent-post/basics).


Manual Setup via YAML or JSON
--------------
You can also configure Recurly via a YAML file by using:

    Recurly.configure_from_yaml("./config/recurly.yml")

The Recurly Configuration YAML is in the format of:

    api_key: your_api_key
    private_key: your_private_key
    subdomain: your_recurly_subdomain


The same format could be applied in JSON instead of YAML using: Recurly.configure_from_json('path/to/file.json')

Clearing test data (Rails3)
----------------

The Recurly Railtie (for rails3) includes a rake task that allows you to easily clear out the test data on your Account. This is useful when automating the testing of the api interation within your own app.

    rake recurly:clear_test_data


Rails Demo Application
----------------

[Recurly Ruby Demo App](http://github.com/recurly/recurly-client-ruby-demo)


Examples
--------

The [API Documentation](http://docs.recurly.com/api/basics) has numerous examples demonstrating how to use the Ruby client library.

All the functionality is demonstrated by the tests in the __spec__ directory.


Running the Specs
------------------

Recurly gem uses RSpec2 for testing. It also uses VCR / Webmock to handle fast and repeatable full integration tests with the API.

The way this works is when each spec is first run, it will save each HTTP request generated within the spec/vcr folder. Subsequent http requests will be mocked using the data contained in these YML files.

The first thing to do is install bundler if you don't already have it:

    gem install bundler

The next thing is to setup all the spec dependencies

    bundle

When first running the specs, you'll need to setup a recurly test account. Use the provided rake task to walk you through creating spec/config/recurly.yml with all the authentication info.

    rake recurly:setup

Now when you run `rake` it will hit recurly's api to run all the specs. Subsequent calls will no longer hit the API (and be run locally).

The tests expect certain plans, add ons, and coupons to be present on the Site you'll be testing against.  You'll need:
    Plan with no trial with a plan_code of 'paid'
    Plan with a trial with a plan_code of 'trial'
    Add ons with codes 'special' and special2' on the 'paid' plan
    Coupon with coupon code 'coupon' which can be applied to all plans


Something go Wrong?
------------------

You can view the full http interactions with Recurly at spec/vcr. Please attached these to any bug reports so we can replicate.


Clearing Test Data in Specs
----------------------------

You can delete the spec/vcr folder at any time, and it will regenerate the requests to recurly's apis. However if you do this, you'll also need to clear the test data on your recurly account. To do this run:

    rake recurly:clear

This will run `recurly:clear_test_data` (using your spec/config/recurly.yml authentication info) to clear out the test data on the server and then delete the associated spec/vcr files so you can start from scratch.

API Documentation
-----------------

Please see the [Recurly API](http://docs.recurly.com/api/basics) for more information and examples.
