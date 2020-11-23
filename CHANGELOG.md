<a name="unreleased"></a>
## Unreleased

<a name="v2.18.18"></a>
## v.2.18.18 (2020-11-23)

* Expose `item_state` and `external_sku` in AddOn class [PR](https://github.com/recurly/recurly-client-ruby/pull/650)
* Handle UnprocessableEntity error for Invoice#refund [PR](https://github.com/recurly/recurly-client-ruby/pull/653)

<a name="v2.18.17"></a>
## v2.18.17 (2020-11-12)

* Expose last_two on BillingInfo class for IBAN accounts and repair tests [PR](https://github.com/recurly/recurly-client-ruby/pull/648)

<a name="v2.18.16"></a>
## v.2.18.16 (2020-11-05)

* Support item-specific coupons [PR](https://github.com/recurly/recurly-client-ruby/pull/644)

<a name="v2.18.15"></a>
## v.2.18.15 (2020-09-17)

* New endpoint to verify an account's billing information [PR](https://github.com/recurly/recurly-client-ruby/pull/636)

<a name="v2.18.14"></a>
## v.2.18.14 (2020-08-20)

This bumps us up to API version 2.29. There are no breaking changes.

* Add tax identifier fields to billing info [PR](https://github.com/recurly/recurly-client-ruby/pull/625)

<a name="v2.18.13"></a>
## v.2.18.13 (2020-08-14)

* Remove surcharge as Avalara recommends [PR](https://github.com/recurly/recurly-client-ruby/pull/618)
* Establish association between Tier and SubscriptionAddOn [PR](https://github.com/recurly/recurly-client-ruby/pull/620)

<a name="v2.18.12"></a>
## v.2.18.12 (2020-07-22)

This bumps us to API version 2.28. There are no breaking changes.

* Fix sub-add-on init bug [PR](https://github.com/recurly/recurly-client-ruby/pull/615)
* BECS support [PR](https://github.com/recurly/recurly-client-ruby/pull/612)

<a name="v2.18.11"></a>
## v.2.18.11 (2020-07-17)

* Add support for Avalara for Communications [PR](https://github.com/recurly/recurly-client-ruby/pull/613)

<a name="v2.18.10"></a>
## v.2.18.10 (2020-06-30)

This bumps us to API version 2.27. There are no breaking changes.

* BACS support [PR](https://github.com/recurly/recurly-client-ruby/pull/595)
* Support items on subscriptions [PR](https://github.com/recurly/recurly-client-ruby/pull/598)

<a name="v2.18.9"></a>
## v.2.18.9 (2020-04-14)

* Add missing association to support Tiered Pricing [PR](https://github.com/recurly/recurly-client-ruby/pull/576)

<a name="v2.18.8"></a>
## v.2.18.8 (2020-3-26)

This bumps us to API version 2.26.

* Add item_code to AddOn (included in API version 2.25) [PR](https://github.com/recurly/recurly-client-ruby/pull/559)
* Add SEPA IBAN attributes to billing_info [PR](https://github.com/recurly/recurly-client-ruby/pull/562)
* Tiered pricing [PR](https://github.com/recurly/recurly-client-ruby/pull/565)
* Add mandate_reference attribute to BillingInfo [PR](https://github.com/recurly/recurly-client-ruby/pull/572)

<a name="v2.18.7"></a>
## v2.18.7 (2020-2-20)

This bumps us to API version 2.25.

* Add external_sku to Adjustment (included in API version 2.24) [PR](https://github.com/recurly/recurly-client-ruby/pull/551)
* Add convert_trial() to Subscription [PR](https://github.com/recurly/recurly-client-ruby/pull/553)

<a name="v2.18.6"></a>
## v2.18.6 (2019-12-18)

* Reference reactivate href in xml [PR](https://github.com/recurly/recurly-client-ruby/pull/535)

<a name="v2.18.5"></a>
## v2.18.5 (2019-11-22)

* Add Item notification webhooks [PR](https://github.com/recurly/recurly-client-ruby/pull/533)

<a name="v2.18.4"></a>
## v2.18.4 (2019-11-21)

This bumps us to API version 2.24.

* Add Item class [PR](https://github.com/recurly/recurly-client-ruby/pull/527)
* Hardcode reactivate function for Item class [PR](https://github.com/recurly/recurly-client-ruby/pull/531)

<a name="v2.18.3"></a>
## v2.18.3 (2019-10-22)

* Subscription timeframe changes [PR](https://github.com/recurly/recurly-client-ruby/pull/492)
* Add shipping address to purchase object [PR](https://github.com/recurly/recurly-client-ruby/pull/522)

<a name="v2.18.2"></a>
## v2.18.2 (2019-09-27)

* Fix account acquisition href problems [PR](https://github.com/recurly/recurly-client-ruby/pull/508)
* V2 bump script [PR](https://github.com/recurly/recurly-client-ruby/pull/509)
* Update travis options [PR](https://github.com/recurly/recurly-client-ruby/pull/512)
* Reference Ruby support page [PR](https://github.com/recurly/recurly-client-ruby/pull/513)
* Include OpenSSL::OPENSSL_LIBRARY_VERSION [PR](https://github.com/recurly/recurly-client-ruby/pull/514)

<a name="v2.18.1"></a>
## v2.18.1 (2019-09-13)

* Adds NewShippingAddressNotification webhook [PR](https://github.com/recurly/recurly-client-ruby/pull/502)
* PSD2 billing info changes [PR](https://github.com/recurly/recurly-client-ruby/pull/505)

<a name="v2.18.0"></a>
## v2.18.0 (2019-08-21)

This bumps us to API version 2.22.

* MOTO transactions [PR](https://github.com/recurly/recurly-client-ruby/pull/493)
* Changes for Vertex customers [PR](https://github.com/recurly/recurly-client-ruby/pull/491)

There is one breaking change. It only applies to Vertex users so will not likely affect you.
`Invoice#tax_types[].type` on invoice and preview invoice endpoints is no longer returned.


<a name="v2.17.11"></a>
## v2.17.11 (2019-06-27)

This brings us up to API version 2.21. There are no breaking changes.

- Add support for 3DS authenticated transactions [PR](https://github.com/recurly/recurly-client-ruby/pull/479)

<a name="v2.17.10"></a>
## v2.17.10 (2019-05-21)

This brings us up to API version 2.20. There are no breaking changes.

- Add support for shipping fees [PR](https://github.com/recurly/recurly-client-ruby/pull/470)

<a name="v2.17.9"></a>
## v2.17.9 (2019-05-14)

- Add support for fraud session ID [PR](https://github.com/recurly/recurly-client-ruby/pull/471)

<a name="v2.17.8"></a>
## v2.17.8 (2019-03-12)

This brings us up to API version 2.19. There are no breaking changes.

- Add support for Account Hierarchy [PR](https://github.com/recurly/recurly-client-ruby/pull/444)

<a name="v2.17.7"></a>
## v2.17.7 (2019-03-07)

- Add support for Account Acquisition [PR](https://github.com/recurly/recurly-client-ruby/pull/450)
- Fix link to supported versions section of README [PR](https://github.com/recurly/recurly-client-ruby/pull/454)
- Fix NoMethodError thrown by Resource.invalid! [PR](https://github.com/recurly/recurly-client-ruby/pull/455)

<a name="v2.17.6"></a>
## v2.17.6 (2019-02-19)

This brings us up to API version 2.18. There are no breaking changes.

- Add support for Amazon Regions [PR](https://github.com/recurly/recurly-client-ruby/pull/445)

<a name="v2.17.5"></a>
## v2.17.5 (2019-01-17)

- Fix typo in Changelog [PR](https://github.com/recurly/recurly-client-ruby/pull/440)
- Ensure error message for a single returned error [PR](https://github.com/recurly/recurly-client-ruby/pull/441)

<a name="v2.17.4"></a>
## v2.17.4 (2018-12-11)

This brings us up to API version 2.17. There are no breaking changes.

- Add exemption_certificate to Account [PR](https://github.com/recurly/recurly-client-ruby/pull/434)
- Add gateway_code to Invoice and Subscription [PR](https://github.com/recurly/recurly-client-ruby/pull/432)
- Add transaction_status_updated_notification and updated_invoice_notification webhooks [PR](https://github.com/recurly/recurly-client-ruby/pull/433)
- Fix missing type instance variable [PR](https://github.com/recurly/recurly-client-ruby/pull/436)
- Fix README [PR](https://github.com/recurly/recurly-client-ruby/pull/437)
- Add OpenSSL version to user agent [PR](https://github.com/recurly/recurly-client-ruby/pull/438)

<a name="v2.17.3"></a>
## v2.17.3 (2018-11-06)

- Fix bug related to aliasing company and company_name [PR](https://github.com/recurly/recurly-client-ruby/pull/428)

<a name="v2.17.2"></a>
## v2.17.2 (2018-10-30)

This brings us up to API version 2.16. There are no breaking changes.

- Remove Rails Generator mention in README.md [PR](https://github.com/recurly/recurly-client-ruby/pull/426)
- Gracefully handle XML parsing errors [PR](https://github.com/recurly/recurly-client-ruby/pull/424)
- Add missing webhook properties to models [PR](https://github.com/recurly/recurly-client-ruby/pull/422)
- Do not assume cursor is an integer [PR](https://github.com/recurly/recurly-client-ruby/pull/421)
- Fix bundler warnings [PR](https://github.com/recurly/recurly-client-ruby/pull/420)
- Alias company and company_name [PR](https://github.com/recurly/recurly-client-ruby/pull/413)

<a name="v2.17.1"></a>
## v2.17.1 (2018-09-25)

This brings us up to API version 2.15. There are no breaking changes.

- Add support for Low Balance Gift Card Notification [PR](https://github.com/recurly/recurly-client-ruby/pull/414)
- Support Account Notes [PR](https://github.com/recurly/recurly-client-ruby/pull/405)

<a name="v2.17.0"></a>
## v2.17.0 (2018-09-20)

- Remove Recurly.js v2 code and some other small improvements [PR](https://github.com/recurly/recurly-client-ruby/pull/411)
- Adds missing credit memo opts to invoice refunds [PR](https://github.com/recurly/recurly-client-ruby/pull/415)

### Upgrade Notes

This release contains one breaking change. Older Recurly.js token signing is no longer supported. You should upgrade to version 4 of Recurly.js: https://dev.recurly.com/docs/recurlyjs
The `js` module is still around to support storing the `public_key`.

<a name="v2.16.2"></a>
## v2.16.2 (2018-08-21)

This brings us up to API version 2.14. There are no breaking changes.

- Support TransactionAuthorizedNotification webhook [PR](https://github.com/recurly/recurly-client-ruby/pull/404)
- Support updating an invoice from client [PR](https://github.com/recurly/recurly-client-ruby/pull/399)
- Support custom fields on Subscription#update_notes [PR](https://github.com/recurly/recurly-client-ruby/pull/409)

<a name="v2.16.1"></a>
## v2.16.1 (2018-08-06)

- Adjust inline documentation for clarity, grammar, and syntax [PR](https://github.com/recurly/recurly-client-ruby/pull/393)
- Correctly document the response type in Purchases [PR](https://github.com/recurly/recurly-client-ruby/pull/394)
- Add gateway_token and gateway_code attributes to BillingInfo class [PR](https://github.com/recurly/recurly-client-ruby/pull/395)
- Remove the old recurly binary [PR](https://github.com/recurly/recurly-client-ruby/pull/398)

<a name="v2.16.0"></a>
## v2.16.0 (2018-06-26)

- Don't set the logger in railtie [PR](https://github.com/recurly/recurly-client-ruby/pull/382)
- Make currencies method public [PR](https://github.com/recurly/recurly-client-ruby/pull/386)
- Allow programmer to set gateway code in purchases [PR](https://github.com/recurly/recurly-client-ruby/pull/387)
- Add all_transactions link to Invoice [PR](https://github.com/recurly/recurly-client-ruby/pull/384)
- Auth and Capture for Purchases [PR](https://github.com/recurly/recurly-client-ruby/pull/389)
- Custom Fields [PR](https://github.com/recurly/recurly-client-ruby/pull/391)
- Remove rails code and railtie [PR](https://github.com/recurly/recurly-client-ruby/pull/388)
- Subscription Terms [PR](https://github.com/recurly/recurly-client-ruby/pull/390)

### Upgrade Notes

This brings us up to API version 2.13. The only breaking change is the [removal of the railtie](https://github.com/recurly/recurly-client-ruby/pull/388/commits/c0d038512204c9baa83512620b9585d61ce07845).
The railtie was being included automatically on detecting rails and was automatically setting the `accept_language` for each request.
If this is something you wish to continue doing, you'll need to set this yourself.

<a name="v2.15.4"></a>
## v2.15.4 (2018-05-15)

- API version 2.12 [PR](https://github.com/recurly/recurly-client-ruby/pull/378)
- New Credit Invoice Webhooks [PR](https://github.com/recurly/recurly-client-ruby/pull/380)

<a name="v2.15.2"></a>
## v2.15.2 (2018-04-18)

- Keep original_invoice link on Invoice [PR](https://github.com/recurly/recurly-client-ruby/pull/372)
- Coupon#redeem! should raise Invalid on failure [PR](https://github.com/recurly/recurly-client-ruby/pull/371)

<a name="v2.15.1"></a>
## v2.15.1 (2018-04-02)

- Fix nokogiri security warnings [PR](https://github.com/recurly/recurly-client-ruby/pull/367)
- API v2.11 changes [PR](https://github.com/recurly/recurly-client-ruby/pull/366)

<a name="v2.15.0"></a>
## v2.15.0 (2018-02-27)

- Invoice refunds do not return InvoiceCollection [PR](https://github.com/recurly/recurly-client-ruby/pull/363)
- Support gift card webhook [PR](https://github.com/recurly/recurly-client-ruby/pull/344)
- Fixes to Resource#find_each [PR](https://github.com/recurly/recurly-client-ruby/pull/355)

### Upgrade Notes

#### 1. `Invoice#refund` and `Invoice#refund_amount` return type

If you are upgrading from 2.13.X or 2.14.X, a design bug was fixed. `Invoice#refund` and `Invoice#refund_amount` once again return an `Invoice` and not
an `InvoiceCollection`.

#### 2. `Resource#find_each` arguments

`Resource#find_each` previously only accepted `per_page` but now accepts an `options` Hash for pagination params. If you want to preserve functionality:

```ruby
# Change This
Recurly::Invoice.find_each(50) do |invoice|
  puts invoice
end

# To This
Recurly::Invoice.find_each(per_page: 50) do |invoice|
  puts invoice
end
```

<a name="v2.14.0"></a>
## v2.14.0 (2018-02-20)

*Note*: We recommend upgrading to 2.15.X for a bug fix around Invoice refunds.

- Updates to credit memos feature [PR](https://github.com/recurly/recurly-client-ruby/pull/360)

### Upgrade Notes

#### 1. `Invoice#mark_failed` now returns `InvoiceCollection`

`mark_failed` no longer reloads the invoice with the response returning true or false, it returns either an `InvoiceCollection` if failable and request is successful, it returns `false` if invoice cannot be marked failed. To keep functionality, take the `charge_invoice` of the returned collection:

```ruby
invoice = Recurly::Invoice.find('1001')

failed_collection = invoice.mark_failed
if failed_collection
  invoice = failed_collection.charge_invoice
end
```

#### 2. Subscription previews and `InvoiceCollection`

Subscription previews and preview changes now return `InvoiceCollection`s rather than `Invoice`. Utilize the `charge_invoice` to keep functionality the same:

```ruby
subscription.preview

# Change
invoice = subscription.invoice
# To
invoice = subscription.invoice_collection.charge_invoice
```

<a name="v2.13.0"></a>
## v2.13.0 (2018-02-09)

*Note*: We recommend upgrading to 2.15.X for a bug fix around Invoice refunds.

- Add NewUsageNotification class for Recurly webhook [PR](https://github.com/recurly/recurly-client-ruby/pull/354)
- Verify CVV Endpoint [PR](https://github.com/recurly/recurly-client-ruby/pull/353)
- Credit Memos [PR](https://github.com/recurly/recurly-client-ruby/pull/358)

### Upgrade Notes

This version bumps us to API version 2.10. There are many breaking changes due to the Credit Memos [PR](https://github.com/recurly/recurly-client-ruby/pull/353)

#### 1. InvoiceCollection

When creating or refunding invoices, we now return an `InvoiceCollection` object rather than an `Invoice`. If you wish to upgrade your application without changing functionality, we recommend that you use the `charge_invoice` on the `InvoiceCollection`. Example:

```ruby
# Change this
invoice = my_account.invoice!       # Returns an Invoice

# To this
collection = my_account.invoice!    # Returns an InvoiceCollection
invoice = collection.charge_invoice # Returns an Invoice
```

These methods, which before returned `Invoice` now return `InvoiceCollection`:

* `Purchase.preview!`
* `Purchase.invoice!`
* `Purchase.authorize!`
* `Account#invoice!`
* `Account#build_invoice`

#### 2. Invoice subtotal_* changes

If you want to preserve functionality, change any use of `Invoice#subtotal_after_discount_in_cents` to  `Invoice#subtotal_in_cents`. If you were previously using `Invoice#subtotal_in_cents`, this has been changed to `Invoice#subtotal_before_discount_in_cents`.

#### 3. Invoice Refund -- `refund_apply_order` changed to `refund_method`

If you were using `refund_apply_order` on any refunds, then you need to change this to use `refund_method` instead. The keys from this have changed from (`credit`, `transaction`) to (`credit_first`, `transaction_first`)

```ruby
# If you use `credit` with refund_amount or refund
invoice.refund_amount(1000, 'credit')
invoice.refund(line_items, 'credit')
# Change to use `credit_first`
invoice.refund(line_items, 'credit_first')

# If you use `transaction` with refund_amount or refund
invoice.refund_amount(1000, 'transaction')
invoice.refund(line_items, 'transaction')
# Change to use `transaction_first`
invoice.refund(line_items, 'transaction_first')
```

#### 4. Invoice States

If you are checking `Invoice#state` anywhere, you will want to check that you have the new correct values. `collected` has changed to `paid` and `open` has changed to `pending`. Example:

```ruby
# Change this
if invoice.state == 'collected'
# To this
if invoice.state == 'paid'

# Change this
if invoice.state == 'open'
# To this
if invoice.state == 'pending'
```

<a name="v2.12.1"></a>
## v2.12.1 (2018-01-19)

- Update Rubies on Travis (and add 2.5.0) [PR](https://github.com/recurly/recurly-client-ruby/pull/356)
- Added `proration_rate` float to Adjustment [PR](https://github.com/recurly/recurly-client-ruby/pull/357)

<a name="v2.12.0"></a>
## v2.12.0 (2017-11-20)

- Added purchase authorize endpoint and other API version 2.9 changes. [PR](https://github.com/recurly/recurly-client-ruby/pull/347)

### Upgrade Notes

This version bumps us to API version 2.9. There are a few breaking changes.

1. The 'subscription' link on an instance of `Adjustment` is now only created if adjustment is
originating from a subscription plan charge, setup fee, add on, trial or proration credit.
It is no longer created for other adjustments.
2. Instances of `Transaction` and `Invoice` no longer have a `subscription` link and you must now
use the `subscriptions` link.

<a name="v2.11.3"></a>
## v2.11.3 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.11.2"></a>
## v2.11.2 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.11.1"></a>
## v2.11.1 (2017-10-20)

- Added `subscriptions` link to `Invoice` and `Transaction` [PR](https://github.com/recurly/recurly-client-ruby/pull/342)

<a name="v2.11.0"></a>
## v2.11.0 (2017-10-04)

This release will upgrade us to API version 2.8.

- Added custom invoice notes to `Purchase` [PR](https://github.com/recurly/recurly-client-ruby/pull/340)
- Added `imported_trial` boolean field to `Subscription` [Commit](https://github.com/recurly/recurly-client-ruby/commit/cdfbe9de6203f8f2a3bb533411dd4c16dea138b6)

### Upgrade Notes

There are two breaking changes in this API version you must consider.

#### Country Codes

All `country` fields must now contain valid [2 letter ISO 3166 country codes](https://www.iso.org/iso-3166-country-codes.html). If your country code fails validation, you will receive a validation error. This affects any endpoint where an address is collected.

#### Purchase Currency

The purchases endpoint can create and invoice multiple adjustments at once but our invoices can only contain items in one currency. To make this explicit the currency can no longer be provided on an adjustment, it must be set once for the entire purchase:

```ruby
purchase = Recurly::Purchase.new(
  # The purchase object is the only place you can set the currency:
  currency: 'USD',
  account: {
    account_code: 'someone'
  }
  adjustments: [
    {
       # Remove this currency
       # You can no longer set the currency on adjustment level
       currency: 'USD',
       unit_amount_in_cents: 1000
    }
  ]
)
```

<a name="v2.10.4"></a>
## v2.10.4 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.10.3"></a>
## v2.10.3 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.10.2"></a>
## v2.10.2 (2017-09-27)

- Fix Subscription constructor API breakage [PR](https://github.com/recurly/recurly-client-ruby/pull/339)

<a name="v2.10.1"></a>
## v2.10.1 (2017-07-03)

**NOTE**: This release contains an accidental breaking change on `Subscription.new`.
See [#338](https://github.com/recurly/recurly-client-ruby/issues/338) for more details.
Upgrade to 2.10.2 for the fix.

This release will upgrade us to API version 2.7.

- Added `updated_account_notification` notification event [PR](https://github.com/recurly/recurly-client-ruby/pull/326)
- Removed Plan#trial_requires_billing_info coercion [PR](https://github.com/recurly/recurly-client-ruby/pull/329)
- Fixed "address" being serialized as "addres" bug [PR](https://github.com/recurly/recurly-client-ruby/pull/330)
- Bump to API v2.7 (Purchase endpoint updates) [PR](https://github.com/recurly/recurly-client-ruby/pull/332)

<a name="v2.10.0"></a>
## v2.10.0 (2017-05-19)

- resource_class option should be class_name and other mislabeled options [PR](https://github.com/recurly/recurly-client-ruby/pull/321)
- Upgrade rake to fix warnings [PR](https://github.com/recurly/recurly-client-ruby/pull/323)
- Purchases endpoint [PR](https://github.com/recurly/recurly-client-ruby/pull/322)
- Removal of X-Records header [PR](https://github.com/recurly/recurly-client-ruby/pull/324)

### Upgrade Notes:

This release will upgrade us to API version 2.6. There are two breaking changes:

1. Since the X-Records header was removed in the pagination endpoint, you can no longer call `count` on a `Pager` and expect it to return a cached response.
From now on, when you call `Pager#count`, it will send a `HEAD` request to the server. So make sure you aren't calling that method in places where you expect the value
to be cached for you. For more info see [PR #324](https://github.com/recurly/recurly-client-ruby/pull/324).
2. For `POST /v2/subscriptions` Sending `nil` for `total_billing_cycles` attribute will now override plan `total_billing_cycles` setting and will make subscription renew forever.
Omitting the attribute will cause the setting to default to the value of plan `total_billing_cycles`.

<a name="v2.9.2"></a>
## v2.9.2 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.9.1"></a>
## v2.9.1 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.9.0"></a>
## v2.9.0 (2017-04-05)

- Remove Nokogiri as a dependency of the recurly gem. If you'd like to continue using it (for that nice speed boost), make sure to add `gem "nokogiri"` to your Gemfile. [PR](https://github.com/recurly/recurly-client-ruby/pull/302)
- Add sort and filter params to Pager rubydocs [PR](https://github.com/recurly/recurly-client-ruby/pull/318)
- Ban nokogiri on dead rubies [PR](https://github.com/recurly/recurly-client-ruby/pull/317)
- Fix Address serialization bug (serialize every attribute on update) [PR](https://github.com/recurly/recurly-client-ruby/pull/315)
- Upgrade webmock so specs can run on ruby 2.4 [PR](https://github.com/recurly/recurly-client-ruby/pull/314)

### Upgrade Notes:
Ruby 1.9 and 2.0 are now deprecated. You may no longer use
nokogiri on these rubies. Please see [PR #317](https://github.com/recurly/recurly-client-ruby/pull/317) for more information.
If you wish to use nokogiri and it's not already required (by rails for instance), you will need to explicitly add it as a dependency and require it.

<a name="v2.8.2"></a>
## v2.8.2 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.8.1"></a>
## v2.8.1 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.8.0"></a>
## v2.8.0 (2017-03-21)

- Finishes API v2.5 updates [PR](https://github.com/recurly/recurly-client-ruby/pull/301)
- Adding product_code to Transactions and Adjustments [PR](https://github.com/recurly/recurly-client-ruby/pull/298)
- Adding all_line_items [PR](https://github.com/recurly/recurly-client-ruby/pull/293)
- Implement fields for Vertex integration [PR](https://github.com/recurly/recurly-client-ruby/pull/289)
- Adds geo_code to billing_info, account address, and shipping address [PR](https://github.com/recurly/recurly-client-ruby/pull/273)
- Guard against passing `Resource.find` empty strings #307 [PR](https://github.com/recurly/recurly-client-ruby/pull/307)
- Add yard docs link #305 [PR](https://github.com/recurly/recurly-client-ruby/pull/305)

### Upgrade Notes:
If you are using `as_json` on a Resource (previously unsupported) we are now returning the attributes as json rather than the resource as json. This means your returned Hash will not have an `attributes` key but will rather BE the `attributes` value. See #295

<a name="v2.7.8"></a>
## v2.7.8 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.7.7"></a>
## v2.7.7 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.7.6"></a>
## v2.7.6 (2017-01-30)

- Fix cloudflare 502 error #296 [PR](https://github.com/recurly/recurly-client-ruby/pull/296)
- Fix stack-level-too-deep for as_json #295 [PR](https://github.com/recurly/recurly-client-ruby/pull/295)

<a name="v2.7.5"></a>
## v2.7.5 (2016-11-30)

- Fix coupon redemption bug on bulk coupons #284 [PR](https://github.com/recurly/recurly-client-ruby/pull/286)

<a name="v2.7.4"></a>
## v2.7.4 (2016-11-17)

- Fix coupon redemption errors [PR](https://github.com/recurly/recurly-client-ruby/pull/271)
- Remove "base" from pretty printed error messages [PR](https://github.com/recurly/recurly-client-ruby/pull/267)
- Fix rails deprecation warning [PR](https://github.com/recurly/recurly-client-ruby/pull/275)
- Add `updated_at` to `MeasuredUnit` [PR](https://github.com/recurly/recurly-client-ruby/pull/263)
- Support gift card `canceled_at` timestamp [PR](https://github.com/recurly/recurly-client-ruby/pull/264)
- Fix AddOns quantity accumulator bug from #226 [PR](https://github.com/recurly/recurly-client-ruby/pull/278)
- Fix Ruby 1.9.3 and jruby testing dependencies [PR](https://github.com/recurly/recurly-client-ruby/pull/279)
- Add new dunning event webhook [PR](https://github.com/recurly/recurly-client-ruby/pull/277)
- Add `timeframe` attribute to `Subscription` [PR](https://github.com/recurly/recurly-client-ruby/pull/283)

<a name="v2.7.3"></a>
## v2.7.3 (2016-08-19)

- Gift cards support was not merged properly in [#257](https://github.com/recurly/recurly-client-ruby/pull/257). This adds it correctly.

<a name="v2.7.2"></a>
## v2.7.2 (2016-08-15)

- Support Shipping Addresses [PR](https://github.com/recurly/recurly-client-ruby/pull/259)

<a name="v2.7.1"></a>
## v2.7.1 (2016-08-04)

Bumps to API version 2.4

- Add `updated_at` fields [PR](https://github.com/recurly/recurly-client-ruby/pull/256)
- Add support for gift cards [PR](https://github.com/recurly/recurly-client-ruby/pull/257)

<a name="v2.7.0"></a>
## v2.7.0 (2016-07-07)

- API Version 2.3 [PR](https://github.com/recurly/recurly-client-ruby/pull/253)

<a name="v2.6.3"></a>
## v2.6.3 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.6.2"></a>
## v2.6.2 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.6.1"></a>
## v2.6.1 (2016-06-01)

* Fix method missing `changed?` in `Account` [PR](https://github.com/recurly/recurly-client-ruby/pull/251)

<a name="v2.6.0"></a>
## v2.6.0 (2016-06-01)

* Add support for free trial coupons [PR](https://github.com/recurly/recurly-client-ruby/pull/245)
* Add support for `roku_billing_agreement_id` [PR](https://github.com/recurly/recurly-client-ruby/pull/246)
* Fix `Account#address_changed?` dirty check [PR](https://github.com/recurly/recurly-client-ruby/pull/248)
* Add support for `<fraud>` if it exists on `Transaction` [PR](https://github.com/recurly/recurly-client-ruby/pull/244)
* Fix updating `unit_amount_in_cents` on `Subscription` [PR](https://github.com/recurly/recurly-client-ruby/pull/241)
* Fix stray `puts` in specs [PR](https://github.com/recurly/recurly-client-ruby/pull/239)

### Upgrade Notes
This version has a bug around creating accounts. We recommend using 2.6.1 or later https://github.com/recurly/recurly-client-ruby/releases/tag/v2.6.1

<a name="v2.5.4"></a>
## v2.5.4 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.5.3"></a>
## v2.5.3 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.5.2"></a>
## v2.5.2 (2016-05-02)

* Remove Gemfile.lock, add more rubies to testing matrix [PR](https://github.com/recurly/recurly-client-ruby/pull/234)
* Remove autoload and reorder requires [PR](https://github.com/recurly/recurly-client-ruby/pull/236)
* Usage Based Billing [PR](https://github.com/recurly/recurly-client-ruby/pull/237)

<a name="v2.5.1"></a>
## v2.5.1 (2016-02-18)

* Add `currency` attribute to `BillingInfo` object so client can pass currency on create/update [PR](https://github.com/recurly/recurly-client-ruby/pull/231)

<a name="v2.5.0"></a>
## v2.5.0 (2016-01-13)

* Fix redemption destroy path for accounts with multiple redemptions [PR](https://github.com/recurly/recurly-client-ruby/pull/227)

### Upgrade Notes
This release has API breaking changes around coupon redemptions. See [PR](https://github.com/recurly/recurly-client-ruby/pull/227) to see if you are affected.

<a name="v2.4.11"></a>
## v2.4.11 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.4.10"></a>
## v2.4.10 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.4.9"></a>
## v2.4.9 (2015-11-18)

* Fixed array change tracking issue around redemptions [PR](https://github.com/recurly/recurly-client-ruby/pull/223)

<a name="v2.4.8"></a>
## v2.4.8 (2015-10-21)

* Add `cc_emails` attribute to `Account` [PR](https://github.com/recurly/recurly-client-ruby/pull/216)
* Add webhooks parsers [PR](https://github.com/recurly/recurly-client-ruby/pull/217)
* Fixed `setup_fee_accounting_code` spec [PR](https://github.com/recurly/recurly-client-ruby/pull/218)

<a name="v2.4.7"></a>
## v2.4.7 (2015-10-02)

* Ignore associations defined in xml but not in the Resource subclasses [PR](https://github.com/recurly/recurly-client-ruby/pull/212)
* Added support for editing and restoring coupons [PR](https://github.com/recurly/recurly-client-ruby/pull/214)
* Added support for bulk coupons and coupon code generation [PR](https://github.com/recurly/recurly-client-ruby/pull/213)

<a name="v2.4.6"></a>
## v2.4.6 (2015-8-31)

* Added `applies_to_non_plan_charges` attribute to `Coupon`
* Adding `gateway_error_code` to `Transaction`
* Adding `redemption_resource` to `Coupon`
* Added `max_redemptions_per_account` attribute to `Coupon`
* Added `redemptions` attribute to `Subscription`
* Added `setup_fee_accounting_code` attribute to `Plan`
* Add support for `Resource.find_each` to be chained with other iterator methods without passing a block

<a name="v2.4.5"></a>
## v2.4.5 (2015-7-31)

* Added ability to enter offline payment [PR](https://github.com/recurly/recurly-client-ruby/pull/189/)
* Add `tax_exempt`, `tax_code`, and `accounting_code` support for one time transactions [PR](https://github.com/recurly/recurly-client-ruby/pull/198)
* Added `duration`, `temporal_unit`, and `temporal_amount` to 'Coupon' [PR](https://github.com/recurly/recurly-client-ruby/pull/202)

<a name="v2.4.4"></a>
## v2.4.4 (2015-6-25)

* Added config to Recurly to allow for per thread configuration of Recurly client. [PR](https://github.com/recurly/recurly-client-ruby/pull/190)
* Add `refund_apply_order` to `Invoice` when creating a refund [PR](https://github.com/recurly/recurly-client-ruby/pull/193)
* Fix association loading when fetching a resource via RJSv2 [PR](https://github.com/recurly/recurly-client-ruby/pull/195)

<a name="v2.4.3"></a>
## v2.4.3 (2015-5-26)

* Add `bank_account_authorized_at` to `Subscription` [PR](https://github.com/recurly/recurly-client-ruby/pull/191)
* Add `ip_address` to `Transaction` [PR](https://github.com/recurly/recurly-client-ruby/pull/192)

<a name="v2.4.2"></a>
## v2.4.2 (2015-4-28)
* Fix paged resource loading when the uuid needs to be escaped, fixes [174](https://github.com/recurly/recurly-client-ruby/issues/174), [PR](https://github.com/recurly/recurly-client-ruby/pull/177)
* Add `tax_type`, `tax_rate`, `tax_region` to `Adjustment` [PR](https://github.com/recurly/recurly-client-ruby/pull/180)
* Add `net_terms` and `collection_method` to `Invoice` [PR](https://github.com/recurly/recurly-client-ruby/pull/186)
* Added `bank_account` attributes to `BillingInfo`:
  * `name_on_account`
  * `account_type` (`checking` or `savings`)
  * `last_four`
  * `routing_number`
  * [PR](https://github.com/recurly/recurly-client-ruby/pull/188)

<a name="v2.4.1"></a>
## v2.4.1 (2015-1-23)
* Add `vat_location_valid` to `Account` [PR](https://github.com/recurly/recurly-client-ruby/pull/171)
* Add `Invoice#invoice_number_prefix` and `Invoice#invoice_number_with_prefix` to make use of the new
  Country Invoice Sequencing feature [PR](https://github.com/recurly/recurly-client-ruby/pull/173)
* Fixes issue with `Subscription#pending_subscription` currency value [PR](https://github.com/recurly/recurly-client-ruby/pull/175)

<a name="v2.4.0"></a>
## v2.4.0 (2015-1-7)
* Add `Invoice#original_invoice` for refund invoices [PR](https://github.com/recurly/recurly-client-ruby/pull/169)

<a name="v2.3.10"></a>
## v2.3.10 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.3.9"></a>
## v2.3.9 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.

<a name="v2.3.8"></a>
## v2.3.8 (2014-12-22)

* Add `Invoice#tax_region` and `Subscription#tax_region` [PR](https://github.com/recurly/recurly-client-ruby/pull/163)
* Add `Invoice#address` and `Subscription#address` when previewing [PR](https://github.com/recurly/recurly-client-ruby/pull/165)
* Add `Subscription#update_notes` to update a subscription's notes [PR](https://github.com/recurly/recurly-client-ruby/pull/165)
* Add `AddOn#accounting_code` [PR](https://github.com/recurly/recurly-client-ruby/pull/164)

<a name="v2.3.7"></a>
## v2.3.7 (2014-12-8)

* Add 'public_key' property to Recurly.js [1ad6aa0](https://github.com/recurly/recurly-client-ruby/pull/155)
* Adds support for reading and writing custom invoice notes [PR](https://github.com/recurly/recurly-client-ruby/pull/158)
* Add `Plan#tax_code`, `AddOn#tax_code` and `Adjustment#tax_code` [PR](https://github.com/recurly/recurly-client-ruby/pull/160)

<a name="v2.3.6"></a>
## v2.3.6 (2014-11-4)

* Fixes issue with broken association lookups [ca0b015](https://github.com/recurly/recurly-client-ruby/commit/ca0b015fead172bdd01dce0a0878a8949c5ccac4)

<a name="v2.3.5"></a>
## v2.3.5 (2014-10-30)

* Adding invoice refunds by line item: `invoice.refund(line_items)` [9acc7a5](https://github.com/recurly/recurly-client-ruby/commit/9acc7a54a5f9cfd8393800abea9f8b8455203fbc)

<a name="v2.3.4"></a>
## v2.3.4 (2014-10-3)

* Adding invoice preview: `account.build_invoice` [0bc0d01](https://github.com/recurly/recurly-client-ruby/pull/153)

<a name="v2.3.3"></a>
## v2.3.3 (2014-9-29)

* Adding the bulk parameter to the `Subscription#postpone` method [8bf72bc](https://github.com/recurly/recurly-client-ruby/pull/150)

<a name="v2.3.2"></a>
## v2.3.2 (2014-9-9)

### Features

* Added Amazon Billing Agreement support [024269](https://github.com/recurly/recurly-client-ruby/commit/02426910ea986317374083fc0b94928cf3b2d569)
* Added account `entity_use_code` when the site is integrated with Avalara [633df6](https://github.com/recurly/recurly-client-ruby/commit/633df6f6d91b02b9bb01ac587030e4011f5ab533)
* Added bulk parameter [8cb157](https://github.com/recurly/recurly-client-ruby/commit/8cb1579378442c23930aee53a3a1a397e72ca86e)

<a name="v2.3.1"></a>
## v2.3.1 (2014-5-23)

### Features

* Added subscription change preview: `subscription.preview` [57a69d3](https://github.com/recurly/recurly-client-ruby/commit/57a69d3301497774e7d34dfe9095908ed2210de7)
* Added subscription estimated cost for new and change previews: `subscription.cost_in_cents` [57a69d3](https://github.com/recurly/recurly-client-ruby/commit/57a69d3301497774e7d34dfe9095908ed2210de7)
* Added subscription remaining billing cycles: `subscription.remaining_billing_cycles` [PR](https://github.com/recurly/recurly-client-ruby/pull/142)

<a name="v2.3.0"></a>
## v2.3.0 (2014-5-14)

#### Features

* Added subscription preview: `Recurly::Subscription.preview` [0d55115](https://github.com/recurly/recurly-client-ruby/commit/0d55115b6155b6a2fb36bfbfcf0cd797f861841e)
* Added tax details to adjustments: `adjustment.tax_details` [c672258](https://github.com/recurly/recurly-client-ruby/commit/c6722589a6174fd2c791d4393522508ec4223694)
* Removed `taxable` support on adjustments [b542b8a](https://github.com/recurly/recurly-client-ruby/commit/b542b8a16616ba7d4cc1da22200ea3eb7ba426b0)
* Added `tax_exempt` to accounts, adjustments and plans [b542b8a](https://github.com/recurly/recurly-client-ruby/commit/b542b8a16616ba7d4cc1da22200ea3eb7ba426b0)
* Added `tax_rate`, `tax_type` to invoices and subscriptions [6a43f37](https://github.com/recurly/recurly-client-ruby/commit/6a43f37b86eb659aa99be4cf48bed0f07927b197)
* Added `tax_in_cents` to subscriptions [6a43f37](https://github.com/recurly/recurly-client-ruby/commit/6a43f37b86eb659aa99be4cf48bed0f07927b197)

<a name="v2.2.5"></a>
## v2.2.5 (2017-11-10)

- Fix `Resource#reload` method.

<a name="v2.2.4"></a>
## v2.2.4 (2017-11-09)

- Fix SSRF vulnerability in `Resource#find`. CVE is pending.
- Backported fix for URL encoding [#157](https://github.com/recurly/recurly-client-ruby/pull/157)

<a name="v2.2.3"></a>
## v2.2.3 (2014-5-9)

* Added `token_id` support to `BillingInfo` [#137](https://github.com/recurly/recurly-client-ruby/pull/137)

<a name="v2.2.2"></a>
## v2.2.2 (2014-2-21)

#### Features

* Added ability to determine a transaction's payment method: `Transaction#payment_method` ([PR](https://github.com/recurly/recurly-client-ruby/pull/125))
* Added ability to determine the date an invoice was closed: `Invoice#closed_at` ([PR](https://github.com/recurly/recurly-client-ruby/pull/125))

#### Bug Fixes

* The gem now explicitly requires Ruby 1.9.3 or newer ([PR](https://github.com/recurly/recurly-client-ruby/pull/129))

<a name="v2.2.1"></a>
## v2.2.1 (2014-1-2)

#### Features

* Added ability to get the active invoice for a subscription: `Subscription#invoice` ([PR](https://github.com/recurly/recurly-client-ruby/pull/125))
* Added ability to get the subscription for an adjustment: `Adjustment#subscription` ([PR](https://github.com/recurly/recurly-client-ruby/pull/125))
* Added ability to get the subscription for a invoice: `Invoice#subscription` ([PR](https://github.com/recurly/recurly-client-ruby/pull/125))


<a name="v2.2.0"></a>
## v2.2.0 (2013-11-12)

#### Bug Fixes

* Raise `Recurly::Error` for all internal HTTP errors ([f3c473a](https://github.com/recurly/recurly-client-ruby/commit/f3c473aa290867ae5eb35eec5b2741b19d1548e5))
* Correctly serialize all API links for a resource so that they are not lost on cache marshalling ([c8ae2d5](https://github.com/recurly/recurly-client-ruby/commit/c8ae2d5e5a283cd1cb86536345b22b536f5ff619))

#### Features

* Added easier way to get an add-on from the subscription: `SubscriptionAddOn#addon` ([8ad87c6](https://github.com/recurly/recurly-client-ruby/commit/8ad87c675425b69174687657ffcbea1272d696aa))
* Drop support for Ruby < 1.9.3 ([b0f1daa](https://github.com/recurly/recurly-client-ruby/commit/b0f1daae53e7ca3e51de14572f65fb5af23c667a))
