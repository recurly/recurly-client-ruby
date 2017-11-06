# Recurly [![Build Status](https://secure.travis-ci.org/recurly/recurly-client-ruby.png?branch=master)](http://travis-ci.org/recurly/recurly-client-ruby) [![Gem Version](https://badge.fury.io/rb/recurly.svg)](http://badge.fury.io/rb/recurly)

<https://github.com/recurly/recurly-client-ruby>

[Recurly](https://recurly.com/)'s Ruby client library is an interface to its
[REST API](https://dev.recurly.com/docs/getting-started).

You can also look at [rubydocs](http://www.rubydoc.info/github/recurly/recurly-client-ruby/master)
to see documentation on the classes and methods available.

## Installation

Recurly is packaged as a Ruby gem. We recommend you install it with
[Bundler](http://gembundler.com/) by adding the following line to your Gemfile:

``` ruby
gem 'recurly', '~> 2.11.1'
```

Recurly will automatically use [Nokogiri](http://nokogiri.org/) (for a nice
speed boost) if it's available and loaded in your app's environment.

## Configuration

If you're using Rails, you can generate an initializer with the following
command:

``` bash
$ rails g recurly:config
```

If you're not using Rails, use the following template:

``` ruby
Recurly.subdomain      = ENV['RECURLY_SUBDOMAIN']
Recurly.api_key        = ENV['RECURLY_API_KEY']
```

Configure the client library with
[your API credentials](https://app.recurly.com/go/developer/api_access).

* `RECURLY_SUBDOMAIN` should contain subdomain for your recurly account.
* `RECURLY_API_KEY` is your "Private API Key" which can be found under "API Credentials" on the `api_access` admin page.

The default currency is USD. To override with a different code:

``` ruby
Recurly.default_currency = 'EUR' # Assign nil to disable the default entirely.
```

If you are using [Recurly.js](https://js.recurly.com) you can store "Public API Key" (which can be found
under "API Credentials" on the `api_access` admin page):

``` ruby
Recurly.js.public_key = ENV['RECURLY_PUBLIC_API_KEY']
```

Then, in your Rails project you can create `recurly_service.js.erb` file and
[configure](https://docs.recurly.com/js/#configure) recurly.js with public key this way:

``` js
recurly.configure({ publicKey: '<%= Recurly.js.public_key %>'});
```

The client library currently uses a Net::HTTP adapter. If you need to
configure the settings passed to Net::HTTP (e.g., an SSL certificates path or timeout lengths),
make sure you assign them when initializing the library:

``` ruby
Recurly::API.net_http = {
  ca_path: "/etc/ssl/certs",
  open_timeout: 5, # 5 seconds (defaults to 60)
  read_timeout: 45 # 45 seconds (defaults to 60)
}
```

To see which keys are supported for this Hash, see the `Attributes` section
of the [Net::HTTP documentation](http://ruby-doc.org/stdlib-2.4.1/libdoc/net/http/rdoc/Net/HTTP.html) for your ruby version.

## Multi-Threaded Configuration
If you are using the client in a multi-threaded environment and require a different configuration per
thread you can use the following within the thread's context:

``` ruby
Recurly.config({
  subdomain: ENV['RECURLY_SUBDOMAIN']
  api_key: ENV['RECURLY_API_KEY'],
  default_currency: "US",
  private_key:  ENV['RECURLY_PUBLIC_API_KEY']
})
```

Any configuration items you do not include in the above config call will be defaulted to the standard
configuration items. For example if you do not define default_currency then Recurly.default_currency
will be used.

## Supported Versions

We are currently supporting versions `2.1.0` and above. `1.9` and `2.0` will still work but are deprecated.

If you are still using one of these rubies, you should know that support for them ended in
2015 (1.9) and 2016 (2.0) and continuing to use them is a security risk.

- https://www.ruby-lang.org/en/news/2015/02/23/support-for-ruby-1-9-3-has-ended/
- https://www.ruby-lang.org/en/news/2016/02/24/support-plan-of-ruby-2-0-0-and-2-1/

For now, we are still running the tests on 1.9 and 2.0 but without `nokogiri` and only `rexml`. Nokogiri is
no longer supported on 1.9 or 2.0 and has patched known vulnerabilities since dropping support.
If you must run one of these rubies (this includes jruby1.7), you must use rexml and not nokogiri.

## Usage

Instructions and examples are available on
[Recurly's documentation site](https://dev.recurly.com/docs/getting-started).

Recurly's gem API is available
[here](http://rubydoc.info/gems/recurly/frames/Recurly).

## Support

- [https://support.recurly.com](https://support.recurly.com)
- [stackoverflow](http://stackoverflow.com/questions/tagged/recurly)

## Contributing

Developing for the Recurly gem is easy with [Bundler](http://gembundler.com/).

Fork and clone the repository, `cd` into the directory, and, with a Ruby of your choice
(1.9.3 or greater), set up your environment.

If you don't have Bundler installed, install it with the following command:

``` bash
$ [sudo] gem install bundler
```

And bundle:

``` bash
$ bundle --path=vendor/bundle
```

You should now be able to run the test suite with Rake:

``` bash
$ bundle exec rake
```

To run the suite using Nokogiri:

``` bash
$ XML=nokogiri bundle exec rake
```

If you plan on submitting a patch, please write tests for it (we use
[MiniTest::Spec](http://bfts.rubyforge.org/minitest/MiniTest/Expectations.html)).

If everything looks good, submit a pull request on GitHub and we'll bring in your changes.

## License

(The MIT License.)

© 2009–2017 Recurly Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
