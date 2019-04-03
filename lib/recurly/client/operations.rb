# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  class Client
    def api_version
      "v2018-06-06"
    end

    # List sites
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_sites list_sites api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @return [Pager<Resources::Site>] A list of sites.
    def list_sites(**options)
      path = "/sites"
      pager(path, **options)
    end

    # Fetch a site
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_site get_site api documenation}
    #
    # @return [Resources::Site] A site.
    def get_site()
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path)
    end

    # List a site's accounts
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_accounts list_accounts api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param subscriber [String] Filter accounts accounts with or without a subscription in the +active+,
    #   +canceled+, or +future+ state.
    #
    # @param past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    def list_accounts(**options)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      pager(path, **options)
    end

    # Create an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_account create_account api documenation}
    #
    # @param body [Requests::AccountCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountCreate}
    # @return [Resources::Account] An account.
    def create_account(body:)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      post(path, body, Requests::AccountCreate)
    end

    # Fetch an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_account get_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    def get_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Modify an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_account update_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::AccountUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdate}
    # @return [Resources::Account] An account.
    def update_account(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      put(path, body, Requests::AccountUpdate)
    end

    # Deactivate an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/deactivate_account deactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    def deactivate_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Fetch an account's acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_account_acquisition get_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::AccountAcquisition] An account's acquisition data.
    def get_account_acquisition(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Update an account's acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_account_acquisition update_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::AccountAcquisitionUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountAcquisitionUpdatable}
    # @return [Resources::AccountAcquisition] An account's updated acquisition data.
    def update_account_acquisition(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      put(path, body, Requests::AccountAcquisitionUpdatable)
    end

    # Remove an account's acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_account_acquisition remove_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    def remove_account_acquisition(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Reactivate an inactive account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/reactivate_account reactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    def reactivate_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/reactivate", site_id: site_id, account_id: account_id)
      put(path)
    end

    # Fetch an account's balance and past due status
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_account_balance get_account_balance api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::AccountBalance] An account's balance.
    def get_account_balance(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/balance", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Fetch an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_billing_info get_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::BillingInfo] An account's billing information.
    def get_billing_info(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Set an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_billing_info update_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @return [Resources::BillingInfo] Updated billing information.
    def update_billing_info(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      put(path, body, Requests::BillingInfoCreate)
    end

    # Remove an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_billing_info remove_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    def remove_billing_info(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Show the coupon redemptions for an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_coupon_redemptions list_account_coupon_redemptions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    def list_account_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemption that is active on an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_active_coupon_redemption get_active_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::CouponRedemption] An active coupon redemption on an account.
    def get_active_coupon_redemption(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Generate an active coupon redemption on an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_coupon_redemption create_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::CouponRedemptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponRedemptionCreate}
    # @return [Resources::CouponRedemption] Returns the new coupon redemption.
    def create_coupon_redemption(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      post(path, body, Requests::CouponRedemptionCreate)
    end

    # Delete the active coupon redemption from an account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_coupon_redemption remove_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::CouponRedemption] Coupon redemption deleted.
    def remove_coupon_redemption(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # List an account's credit payments
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_credit_payments list_account_credit_payments api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::CreditPayment>] A list of the account's credit payments.
    def list_account_credit_payments(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/credit_payments", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_invoices list_account_invoices api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param type [String] Filter by type when:
    #   - +type=charge+, only charge invoices will be returned.
    #   - +type=credit+, only credit invoices will be returned.
    #   - +type=non-legacy+, only charge and credit invoices will be returned.
    #   - +type=legacy+, only legacy invoices will be returned.
    #
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    def list_account_invoices(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_invoice create_invoice api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @return [Resources::InvoiceCollection] Returns the new invoices.
    def create_invoice(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # Preview new invoice for pending line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/preview_invoice preview_invoice api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @return [Resources::InvoiceCollection] Returns the invoice previews.
    def preview_invoice(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices/preview", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # List an account's line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_line_items list_account_line_items api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    def list_account_line_items(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_line_item create_line_item api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}
    # @return [Resources::LineItem] Returns the new line item.
    def create_line_item(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      post(path, body, Requests::LineItemCreate)
    end

    # Fetch a list of an account's notes
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_notes list_account_notes api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    def list_account_notes(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_account_note get_account_note api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param account_note_id [String] Account Note ID.
    # @return [Resources::AccountNote] An account note.
    def get_account_note(account_id:, account_note_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes/{account_note_id}", site_id: site_id, account_id: account_id, account_note_id: account_note_id)
      get(path)
    end

    # Fetch a list of an account's shipping addresses
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_shipping_addresses list_shipping_addresses api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    def list_shipping_addresses(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_shipping_address create_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::ShippingAddressCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressCreate}
    # @return [Resources::ShippingAddress] Returns the new shipping address.
    def create_shipping_address(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses", site_id: site_id, account_id: account_id)
      post(path, body, Requests::ShippingAddressCreate)
    end

    # Fetch an account's shipping address
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_shipping_address get_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    # @return [Resources::ShippingAddress] A shipping address.
    def get_shipping_address(account_id:, shipping_address_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      get(path)
    end

    # Update an account's shipping address
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_shipping_address update_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}
    # @return [Resources::ShippingAddress] The updated shipping address.
    def update_shipping_address(account_id:, shipping_address_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate)
    end

    # Remove an account's shipping address
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_shipping_address remove_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    def remove_shipping_address(account_id:, shipping_address_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path)
    end

    # List an account's subscriptions
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_subscriptions list_account_subscriptions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param state [String] Filter by state.
    #   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
    #   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
    #   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    #
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    def list_account_subscriptions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/subscriptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_transactions list_account_transactions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param type [String] Filter by type field.
    # @param success [String] Filter by success field.
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    def list_account_transactions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/transactions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_account_acquisition list_account_acquisition api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::AccountAcquisition>] A list of the site's account acquisition data.
    def list_account_acquisition(**options)
      path = interpolate_path("/sites/{site_id}/acquisitions", site_id: site_id)
      pager(path, **options)
    end

    # List a site's coupons
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_coupons list_coupons api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    def list_coupons(**options)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      pager(path, **options)
    end

    # Create a new coupon
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_coupon create_coupon api documenation}
    #
    # @param body [Requests::CouponCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponCreate}
    # @return [Resources::Coupon] A new coupon.
    def create_coupon(body:)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      post(path, body, Requests::CouponCreate)
    end

    # Fetch a coupon
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_coupon get_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code (use prefix: +code-+, e.g. +code-10off+).
    # @return [Resources::Coupon] A coupon.
    def get_coupon(coupon_id:)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}", site_id: site_id, coupon_id: coupon_id)
      get(path)
    end

    # Update an active coupon
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_coupon update_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code (use prefix: +code-+, e.g. +code-10off+).
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @return [Resources::Coupon] The updated coupon.
    def update_coupon(coupon_id:, body:)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}", site_id: site_id, coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate)
    end

    # List unique coupon codes associated with a bulk coupon
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_unique_coupon_codes list_unique_coupon_codes api documenation}
    #
    # @param coupon_id [String] Coupon ID or code (use prefix: +code-+, e.g. +code-10off+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    def list_unique_coupon_codes(coupon_id:, **options)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}/unique_coupon_codes", site_id: site_id, coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_credit_payments list_credit_payments api documenation}
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::CreditPayment>] A list of the site's credit payments.
    def list_credit_payments(**options)
      path = interpolate_path("/sites/{site_id}/credit_payments", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_credit_payment get_credit_payment api documenation}
    #
    # @param credit_payment_id [String] Credit Payment ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::CreditPayment] A credit payment.
    def get_credit_payment(credit_payment_id:)
      path = interpolate_path("/sites/{site_id}/credit_payments/{credit_payment_id}", site_id: site_id, credit_payment_id: credit_payment_id)
      get(path)
    end

    # List a site's custom field definitions
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_custom_field_definitions list_custom_field_definitions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @return [Pager<Resources::CustomFieldDefinition>] A list of the site's custom field definitions.
    def list_custom_field_definitions(**options)
      path = interpolate_path("/sites/{site_id}/custom_field_definitions", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an custom field definition
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_custom_field_definition get_custom_field_definition api documenation}
    #
    # @param custom_field_definition_id [String] Custom Field Definition ID
    # @return [Resources::CustomFieldDefinition] An custom field definition.
    def get_custom_field_definition(custom_field_definition_id:)
      path = interpolate_path("/sites/{site_id}/custom_field_definitions/{custom_field_definition_id}", site_id: site_id, custom_field_definition_id: custom_field_definition_id)
      get(path)
    end

    # List a site's invoices
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_invoices list_invoices api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param type [String] Filter by type when:
    #   - +type=charge+, only charge invoices will be returned.
    #   - +type=credit+, only credit invoices will be returned.
    #   - +type=non-legacy+, only charge and credit invoices will be returned.
    #   - +type=legacy+, only legacy invoices will be returned.
    #
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    def list_invoices(**options)
      path = interpolate_path("/sites/{site_id}/invoices", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_invoice get_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] An invoice.
    def get_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}", site_id: site_id, invoice_id: invoice_id)
      get(path)
    end

    # Collect a pending or past due, automatic invoice
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/collect_invoice collect_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    def collect_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/collect", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as failed
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/fail_invoice fail_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    def fail_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_failed", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as successful
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/mark_invoice_successful mark_invoice_successful api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    def mark_invoice_successful(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_successful", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Reopen a closed, manual invoice
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/reopen_invoice reopen_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    def reopen_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/reopen", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # List a invoice's line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_invoice_line_items list_invoice_line_items api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    def list_invoice_line_items(invoice_id:, **options)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/line_items", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_invoice_coupon_redemptions list_invoice_coupon_redemptions api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    def list_invoice_coupon_redemptions(invoice_id:, **options)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/coupon_redemptions", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_related_invoices list_related_invoices api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    def list_related_invoices(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/related_invoices", site_id: site_id, invoice_id: invoice_id)
      pager(path)
    end

    # Refund an invoice
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/refund_invoice refund_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}
    # @return [Resources::Invoice] Returns the new credit invoice.
    def refund_invoice(invoice_id:, body:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/refund", site_id: site_id, invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund)
    end

    # List a site's line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_line_items list_line_items api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    def list_line_items(**options)
      path = interpolate_path("/sites/{site_id}/line_items", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a line item
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_line_item get_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @return [Resources::LineItem] A line item.
    def get_line_item(line_item_id:)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      get(path)
    end

    # Delete an uninvoiced line item
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_line_item remove_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    def remove_line_item(line_item_id:)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      delete(path)
    end

    # List a site's plans
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_plans list_plans api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param state [String] Filter by state.
    # @return [Pager<Resources::Plan>] A list of plans.
    def list_plans(**options)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      pager(path, **options)
    end

    # Create a plan
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_plan create_plan api documenation}
    #
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}
    # @return [Resources::Plan] A plan.
    def create_plan(body:)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      post(path, body, Requests::PlanCreate)
    end

    # Fetch a plan
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_plan get_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::Plan] A plan.
    def get_plan(plan_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      get(path)
    end

    # Update a plan
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_plan update_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param body [Requests::PlanUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanUpdate}
    # @return [Resources::Plan] A plan.
    def update_plan(plan_id:, body:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      put(path, body, Requests::PlanUpdate)
    end

    # Remove a plan
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_plan remove_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::Plan] Plan deleted
    def remove_plan(plan_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      delete(path)
    end

    # List a plan's add-ons
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_plan_add_ons list_plan_add_ons api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param state [String] Filter by state.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_plan_add_ons(plan_id:, **options)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons", site_id: site_id, plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_plan_add_on create_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param body [Requests::AddOnCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnCreate}
    # @return [Resources::AddOn] An add-on.
    def create_plan_add_on(plan_id:, body:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons", site_id: site_id, plan_id: plan_id)
      post(path, body, Requests::AddOnCreate)
    end

    # Fetch a plan's add-on
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_plan_add_on get_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::AddOn] An add-on.
    def get_plan_add_on(plan_id:, add_on_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, plan_id: plan_id, add_on_id: add_on_id)
      get(path)
    end

    # Update an add-on
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/update_plan_add_on update_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param body [Requests::AddOnUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnUpdate}
    # @return [Resources::AddOn] An add-on.
    def update_plan_add_on(plan_id:, add_on_id:, body:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, plan_id: plan_id, add_on_id: add_on_id)
      put(path, body, Requests::AddOnUpdate)
    end

    # Remove an add-on
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_plan_add_on remove_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::AddOn] Add-on deleted
    def remove_plan_add_on(plan_id:, add_on_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, plan_id: plan_id, add_on_id: add_on_id)
      delete(path)
    end

    # List a site's add-ons
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_add_ons list_add_ons api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param state [String] Filter by state.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_add_ons(**options)
      path = interpolate_path("/sites/{site_id}/add_ons", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_add_on get_add_on api documenation}
    #
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::AddOn] An add-on.
    def get_add_on(add_on_id:)
      path = interpolate_path("/sites/{site_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id)
      get(path)
    end

    # List a site's subscriptions
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_subscriptions list_subscriptions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param state [String] Filter by state.
    #   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
    #   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
    #   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    #
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    def list_subscriptions(**options)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      pager(path, **options)
    end

    # Create a new subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_subscription create_subscription api documenation}
    #
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}
    # @return [Resources::Subscription] A subscription.
    def create_subscription(body:)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      post(path, body, Requests::SubscriptionCreate)
    end

    # Fetch a subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_subscription get_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A subscription.
    def get_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Modify a subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/modify_subscription modify_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}
    # @return [Resources::Subscription] A subscription.
    def modify_subscription(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate)
    end

    # Terminate a subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/terminate_subscription terminate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param refund [String] The type of refund to perform:
    #
    #   * +full+ - Performs a full refund of the last invoice for the current subscription term.
    #   * +partial+ - Prorates a refund based on the amount of time remaining in the current bill cycle.
    #   * +none+ - Terminates the subscription without a refund.
    #
    #   In the event that the most recent invoice is a $0 invoice paid entirely by credit, Recurly will apply the credit back to the customer’s account.
    #
    #   You may also terminate a subscription with no refund and then manually refund specific invoices.
    #
    # @return [Resources::Subscription] An expired subscription.
    def terminate_subscription(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/cancel_subscription cancel_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A canceled or failed subscription.
    def cancel_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/cancel", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Reactivate a canceled subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/reactivate_subscription reactivate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] An active subscription.
    def reactivate_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/reactivate", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Pause subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/pause_subscription pause_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionPause] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionPause}
    # @return [Resources::Subscription] A subscription.
    def pause_subscription(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/pause", site_id: site_id, subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionPause)
    end

    # Resume subscription
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/resume_subscription resume_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A subscription.
    def resume_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/resume", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Fetch a subscription's pending change
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_subscription_change get_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::SubscriptionChange] A subscription's pending change.
    def get_subscription_change(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Create a new subscription change
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/create_subscription_change create_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @return [Resources::SubscriptionChange] A subscription change.
    def create_subscription_change(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate)
    end

    # Delete the pending subscription change
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/remove_subscription_change remove_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    def remove_subscription_change(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      delete(path)
    end

    # List a subscription's invoices
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_subscription_invoices list_subscription_invoices api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param type [String] Filter by type when:
    #   - +type=charge+, only charge invoices will be returned.
    #   - +type=credit+, only credit invoices will be returned.
    #   - +type=non-legacy+, only charge and credit invoices will be returned.
    #   - +type=legacy+, only legacy invoices will be returned.
    #
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    def list_subscription_invoices(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/invoices", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription's line items
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_subscription_line_items list_subscription_line_items api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the subscription's line items.
    def list_subscription_line_items(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/line_items", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a site's transactions
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/list_transactions list_transactions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
    #   order. In descending order updated records will move behind the cursor and could
    #   prevent some records from being returned.
    #
    # @param begin_time [DateTime] Filter by begin_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param end_time [DateTime] Filter by end_time when +sort=created_at+ or +sort=updated_at+.
    #   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    #
    # @param type [String] Filter by type field.
    # @param success [String] Filter by success field.
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    def list_transactions(**options)
      path = interpolate_path("/sites/{site_id}/transactions", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_transaction get_transaction api documenation}
    #
    # @param transaction_id [String] Transaction ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Transaction] A transaction.
    def get_transaction(transaction_id:)
      path = interpolate_path("/sites/{site_id}/transactions/{transaction_id}", site_id: site_id, transaction_id: transaction_id)
      get(path)
    end

    # Fetch a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/get_unique_coupon_code get_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def get_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      get(path)
    end

    # Deactivate a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/deactivate_unique_coupon_code deactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def deactivate_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      delete(path)
    end

    # Restore a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-06-06#operation/reactivate_unique_coupon_code reactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def reactivate_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}/restore", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      put(path)
    end
  end
end
