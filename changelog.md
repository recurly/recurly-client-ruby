= Recurly Ruby Client Library CHANGELOG

== Version 0.4.5 (April 5, 2011)

- Transparent Post: Fix issue when error "field" attribute is not specified in result.
- Transparent Post API is nearly completion. Please see our Transparent Post demo app for an example: https://github.com/recurly/recurly-client-ruby-transparent-demo

== Version 0.4.4 (April 4,2011)

- Transparent Post: Fixed parsing transparent post errors with no attribute information.
- Transparent Post: Folded in fixes from Eric Lee.

== Version 0.4.3 (April 3, 2011)

- Transparent Post: Replaced the default XML parsing with an improved XML parsing method to read inline error information. ActiveResource's default XML parsing cannot parse errors and objects nested in the same response.
- Parsing error information from 404, 412, and 500s in ActiveResource exceptions.

== Version 0.4.0 (March 3, 2011)

- Added (beta) support for Transparent Post.
- Updated credentials to support using api-production.recurly.com or api-sandbox.recurly.com. Please update your configuration files. This change should improve DNS lookups.
