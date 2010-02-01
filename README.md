Recurly Ruby Client
===================

The Recurly Ruby Client library is an open source library to interact with Recurly's subscription management from your Ruby on Rails website. The library interacts with Recurly's [REST API](http://support.recurly.com/faqs/api).


Usage
-----

Please see the [documentation](http://support.recurly.com/faqs/api/ruby-client) and
[support forums](http://support.recurly.com/discussions) for more information.


Installation
------------

This library can be installed as a gem or a plugin. Your choice.

**Gem Installation:**

    gem install recurly --source=http://gemcutter.org
    
**Plugin Installation:**

    script/plugin install git@github.com:recurly/recurly-client-ruby.git


Authentication
--------------

The Recurly Ruby Client requires a username and password to connect.  We recommend creating a user just for your API.  Please see the [Authentication](http://support.recurly.com/faqs/api/authentication) documentation for more information.

Create a file in your Rails app at __/config/initializers/recurly_config.rb__ with contents like:

    Recurly.configure do |c|
      c.username = 'api@yourcompany.com'
      c.password = 'super_secret_password'
    end


Demo Application
----------------

[Recurly Ruby Demo App](http://github.com/recurly/recurly-client-ruby-demo)

Examples
--------

All the functionality is demonstrated by the unit tests in the __test__ directory.


API Documentation
-----------------

Please see the [Recurly API](http://support.recurly.com/faqs/api/) for more information.