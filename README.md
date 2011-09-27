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


Rails Demo Application
----------------

[Recurly Ruby Demo App](http://github.com/recurly/recurly-client-ruby-demo)


Examples
--------

The [API Documentation](http://docs.recurly.com/api/basics) has numerous examples demonstrating how to use the Ruby client library.

All the functionality is also demonstrated by the tests in the __spec__ directory.


Running the Specs
------------------

Recurly gem uses RSpec2 for testing. It also uses VCR / Webmock to handle fast and repeatable full integration tests with the API.

The way this works is when each spec is first run, it will save each HTTP request generated within the spec/vcr folder. Subsequent http requests will be mocked using the data contained in these YML files.

The specs require API credentials in '/spec/config/recurly.yml' and the following setup in your Recurly account:

* A plan with no trial, use plan_code "paid".
* Add-ons with the codes "special" and "special2" on the "paid" plan.
* A plan with a trial period, use plan_code "trial"
* A coupon with the coupon_code "coupon" which can be applied to all plans.

To re-run specs, you will need to clear the test data from your Recurly account.


API Documentation
-----------------

Please see the [Recurly API](http://docs.recurly.com/api/basics) for more information and examples.
