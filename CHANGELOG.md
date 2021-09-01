# Changelog

## [4.8.0](https://github.com/recurly/recurly-client-ruby/tree/4.8.0) (2021-09-01)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.7.0...4.8.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 (Dunning Campaigns feature) [#724](https://github.com/recurly/recurly-client-ruby/pull/724) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.7.0](https://github.com/recurly/recurly-client-ruby/tree/4.7.0) (2021-08-19)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.6.0...4.7.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 (get_preview_renewal) [#722](https://github.com/recurly/recurly-client-ruby/pull/722) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.6.0](https://github.com/recurly/recurly-client-ruby/tree/4.6.0) (2021-08-11)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.5.0...4.6.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 [#720](https://github.com/recurly/recurly-client-ruby/pull/720) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.5.0](https://github.com/recurly/recurly-client-ruby/tree/4.5.0) (2021-08-02)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.4.0...4.5.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 [#714](https://github.com/recurly/recurly-client-ruby/pull/714) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.4.0](https://github.com/recurly/recurly-client-ruby/tree/4.4.0) (2021-06-15)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.3.0...4.4.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 [#705](https://github.com/recurly/recurly-client-ruby/pull/705) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.3.0](https://github.com/recurly/recurly-client-ruby/tree/4.3.0) (2021-06-04)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.2.0...4.3.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 [#702](https://github.com/recurly/recurly-client-ruby/pull/702) ([recurly-integrations](https://github.com/recurly-integrations))
- Making #post allow a nil body [#699](https://github.com/recurly/recurly-client-ruby/pull/699) ([douglasmiller](https://github.com/douglasmiller))



## [4.2.0](https://github.com/recurly/recurly-client-ruby/tree/4.2.0) (2021-04-21)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.1.0...4.2.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 [#695](https://github.com/recurly/recurly-client-ruby/pull/695) ([recurly-integrations](https://github.com/recurly-integrations))



## [4.1.0](https://github.com/recurly/recurly-client-ruby/tree/4.1.0) (2021-04-14)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.0.1...4.1.0)


**Merged Pull Requests**

- Generated Latest Changes for v2021-02-25 (Backup Payment Method) [#691](https://github.com/recurly/recurly-client-ruby/pull/691) ([recurly-integrations](https://github.com/recurly-integrations))
- Generated Latest Changes for v2021-02-25 [#687](https://github.com/recurly/recurly-client-ruby/pull/687) ([recurly-integrations](https://github.com/recurly-integrations))
- Restoring NetworkError and it's derivatives [#685](https://github.com/recurly/recurly-client-ruby/pull/685) ([douglasmiller](https://github.com/douglasmiller))
- Generated Latest Changes for v2021-02-25 (Usage Percentage on Tiers) [#683](https://github.com/recurly/recurly-client-ruby/pull/683) ([recurly-integrations](https://github.com/recurly-integrations))
- Fixes TypeError caused by attempts to Base64 encode nil @api_key values [#672](https://github.com/recurly/recurly-client-ruby/pull/672) ([alexfulsome](https://github.com/alexfulsome))



## [4.0.1](https://github.com/recurly/recurly-client-ruby/tree/4.0.1) (2021-03-19)

[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/4.0.0...4.0.1)


**Merged Pull Requests**

- Release 4.0.1 [#682](https://github.com/recurly/recurly-client-ruby/pull/682) ([douglasmiller](https://github.com/douglasmiller))
- More ruby 3.0 [#680](https://github.com/recurly/recurly-client-ruby/pull/680) ([douglasmiller](https://github.com/douglasmiller))
- Generated Latest Changes for v2021-02-25 [#678](https://github.com/recurly/recurly-client-ruby/pull/678) ([recurly-integrations](https://github.com/recurly-integrations))
- Sync updates not ported from 3.x client [#671](https://github.com/recurly/recurly-client-ruby/pull/671) ([douglasmiller](https://github.com/douglasmiller))



## [4.0.0](https://github.com/recurly/recurly-client-ruby/tree/4.0.0) (2021-03-01)


# Major Version Release

The 4.x major version of the client pairs with the `v2021-02-25` API version. This version of the client and the API contain breaking changes that should be considered before upgrading your integration.

## Breaking Changes in the API
All changes to the core API are documented in the [Developer Portal changelog](https://developers.recurly.com/api/changelog.html#v2021-02-25---current-ga-version)

## Breaking Changes in Client

- Remove `site_id` and `subdomain` from client initializer.  [#624]
- Remove `set_site_id` method from client.  [#627]
- Classify unexpected error responses from Recurly API via an HTTP status code mapping provided in `Recurly::Errors::ERROR_MAP`.  [#616]
- Remove `NetworkError` class. All error classes now extend the `APIError`. This means that the order of multiple rescue blocks will need to be re-considered.  [#616]

    ### 3.x
    
    ```ruby
    rescue Recurly::Errors::ValidationError => ex
      # catch a validation error
    rescue Recurly::Errors::APIError => ex
      # catch a generic api error
    rescue Recurly::Errors::TimeoutError => ex
      # catch a specific network error
    ```
    
    ### 4.x
    
    ```ruby
    rescue Recurly::Errors::ValidationError => ex
      # catch a validation error
    rescue Recurly::Errors::TimeoutError => ex
      # catch a specific network error
    rescue Recurly::Errors::APIError => ex
      # catch a generic api error
    ```

- Rename `InvalidResponseError` to `InvalidContentTypeError`.  [#616]
- Rename `UnavailableError` to `ServiceUnavailableError`.  [#616]
- Reorganize top-level keys of the optional parameters hash to improve clarity and create space for additional options.  [#619]

    ### 3.x
    
    ```ruby
    options = {
      limit: 200,
      headers: {
        'Accept-Language' => 'fr'
      }
    }
    accounts = @client.list_accounts(options)
    ```
    
    ### 4.x
    
    ```ruby
    options = {
      params: {
          limit: 200
      }
      headers: {
        'Accept-Language' => 'fr'
      }
    }
    accounts = @client.list_accounts(options)
    ```


