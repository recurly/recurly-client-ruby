= Recurly Ruby Client Library CHANGELOG

== Version 0.4.14 (September 22, 2011)

- Added alias for Recurly.password to Recurly.api_key for compatibility with Recurly.configure blocks.

== Version 0.4.13 (September 22, 2011)

- Simplify API credentials. Replaced API username, password, and environment with simply "API Key".
  Please change your `password` to `api_key` in the configuration settings; the library will continue
  to read `api_key` from `password` for backwards compatibility.

== Version 0.4.12 (August 30, 2011)

- Update verification module to support ruby 1.8 

== Version 0.4.11 (August 22, 2011)

- Fix parsing transparent post results on a 422 response.

== Version 0.4.10 (August 19, 2011)

- Rails 3.1 compatibility
- Update parsing of errors on BillingInfo so credit card errors appear on the CreditCard object.
- Added support for Recurly.js

== Version 0.4.8 (July 21, 2011)

- Update custom XML parser for transparent post results to be compatible with Rails 3.1 RC.
- Subscription#change can raise an invalid Active Resource exception: reuse the same error handling as Base#save.

== Version 0.4.7 (April 21, 2011)

- Fix Transaction.refund(amount_in_cents) to pass argument as "amount_in_cents" instead of "amount".
- Fix error message on timeframe for Subscription.change() argument.

== Version 0.4.6 (April 21, 2011)

- Changed "unit_amount" to "unit_amount_in_cents" on Subscription object.
- Added "vat_number" to BillingInfo.
- Added "unit_amount_in_cents" and "quantity" to Charge and Credit objects.
- Fixed sending custom user agent string.

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
