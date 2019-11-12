# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  class Client
    def api_version
      "v2999-01-01"
    end

    # List sites
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_sites list_sites api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_site get_site api documenation}
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Site] A site.
    def get_site(site_id:)
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path)
    end

    # List a site's accounts
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_accounts list_accounts api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param email [String] Filter for accounts with this exact email address. A blank value will return accounts with both +null+ and +""+ email addresses. Note that multiple accounts can share one email address.
    # @param subscriber [Boolean] Filter for accounts with or without a subscription in the +active+,
    #   +canceled+, or +future+ state.
    #
    # @param past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    def list_accounts(**options)
      path = interpolate_path("/accounts")
      pager(path, **options)
    end

    # Create an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_account create_account api documenation}
    #
    # @param body [Requests::AccountCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Account] An account.
    def create_account(body:, **options)
      path = interpolate_path("/accounts")
      post(path, body, Requests::AccountCreate, **options)
    end

    # Fetch an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_account get_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Account] An account.
    def get_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      get(path, **options)
    end

    # Modify an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_account update_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Account] An account.
    def update_account(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      put(path, body, Requests::AccountUpdate, **options)
    end

    # Deactivate an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/deactivate_account deactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Account] An account.
    def deactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      delete(path, **options)
    end

    # Fetch an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_account_acquisition get_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AccountAcquisition] An account's acquisition data.
    def get_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      get(path, **options)
    end

    # Update an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_account_acquisition update_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountAcquisitionUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountAcquisitionUpdatable}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AccountAcquisition] An account's updated acquisition data.
    def update_account_acquisition(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      put(path, body, Requests::AccountAcquisitionUpdatable, **options)
    end

    # Remove an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_account_acquisition remove_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Empty] Acquisition data was succesfully deleted.
    def remove_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      delete(path, **options)
    end

    # Reactivate an inactive account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/reactivate_account reactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Account] An account.
    def reactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/reactivate", account_id: account_id)
      put(path, **options)
    end

    # Fetch an account's balance and past due status
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_account_balance get_account_balance api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AccountBalance] An account's balance.
    def get_account_balance(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/balance", account_id: account_id)
      get(path, **options)
    end

    # Fetch an account's billing information
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_billing_info get_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::BillingInfo] An account's billing information.
    def get_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      get(path, **options)
    end

    # Set an account's billing information
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_billing_info update_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::BillingInfo] Updated billing information.
    def update_billing_info(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      put(path, body, Requests::BillingInfoCreate, **options)
    end

    # Remove an account's billing information
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_billing_info remove_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Empty] Billing information deleted
    def remove_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      delete(path, **options)
    end

    # Show the coupon redemptions for an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_coupon_redemptions list_account_coupon_redemptions api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    def list_account_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions", account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemption that is active on an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_active_coupon_redemption get_active_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::CouponRedemption] An active coupon redemption on an account.
    def get_active_coupon_redemption(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      get(path, **options)
    end

    # Generate an active coupon redemption on an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_coupon_redemption create_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::CouponRedemptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponRedemptionCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::CouponRedemption] Returns the new coupon redemption.
    def create_coupon_redemption(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      post(path, body, Requests::CouponRedemptionCreate, **options)
    end

    # Delete the active coupon redemption from an account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_coupon_redemption remove_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::CouponRedemption] Coupon redemption deleted.
    def remove_coupon_redemption(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      delete(path, **options)
    end

    # List an account's credit payments
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_credit_payments list_account_credit_payments api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CreditPayment>] A list of the account's credit payments.
    def list_account_credit_payments(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/credit_payments", account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_invoices list_account_invoices api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    def list_account_invoices(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_invoice create_invoice api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::InvoiceCollection] Returns the new invoices.
    def create_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # Preview new invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/preview_invoice preview_invoice api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::InvoiceCollection] Returns the invoice previews.
    def preview_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices/preview", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # List an account's line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_line_items list_account_line_items api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    def list_account_line_items(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_line_item create_line_item api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::LineItem] Returns the new line item.
    def create_line_item(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      post(path, body, Requests::LineItemCreate, **options)
    end

    # Fetch a list of an account's notes
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_notes list_account_notes api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    def list_account_notes(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes", account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_account_note get_account_note api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param account_note_id [String] Account Note ID.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AccountNote] An account note.
    def get_account_note(account_id:, account_note_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes/{account_note_id}", account_id: account_id, account_note_id: account_note_id)
      get(path, **options)
    end

    # Fetch a list of an account's shipping addresses
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_shipping_addresses list_shipping_addresses api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    def list_shipping_addresses(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_shipping_address create_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::ShippingAddressCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::ShippingAddress] Returns the new shipping address.
    def create_shipping_address(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      post(path, body, Requests::ShippingAddressCreate, **options)
    end

    # Fetch an account's shipping address
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_shipping_address get_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::ShippingAddress] A shipping address.
    def get_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      get(path, **options)
    end

    # Update an account's shipping address
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_shipping_address update_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::ShippingAddress] The updated shipping address.
    def update_shipping_address(account_id:, shipping_address_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate, **options)
    end

    # Remove an account's shipping address
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_shipping_address remove_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Empty] Shipping address deleted.
    def remove_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path, **options)
    end

    # List an account's subscriptions
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_subscriptions list_account_subscriptions api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    #
    #   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
    #   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
    #   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    def list_account_subscriptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/subscriptions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_transactions list_account_transactions api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param type [String] Filter by type field. The value +payment+ will return both +purchase+ and +capture+ transactions.
    # @param success [String] Filter by success field.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    def list_account_transactions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/transactions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's child accounts
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_child_accounts list_child_accounts api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param email [String] Filter for accounts with this exact email address. A blank value will return accounts with both +null+ and +""+ email addresses. Note that multiple accounts can share one email address.
    # @param subscriber [Boolean] Filter for accounts with or without a subscription in the +active+,
    #   +canceled+, or +future+ state.
    #
    # @param past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Account>] A list of an account's child accounts.
    def list_child_accounts(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/accounts", account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_account_acquisition list_account_acquisition api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::AccountAcquisition>] A list of the site's account acquisition data.
    def list_account_acquisition(**options)
      path = interpolate_path("/acquisitions")
      pager(path, **options)
    end

    # List a site's coupons
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_coupons list_coupons api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    def list_coupons(**options)
      path = interpolate_path("/coupons")
      pager(path, **options)
    end

    # Create a new coupon
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_coupon create_coupon api documenation}
    #
    # @param body [Requests::CouponCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Coupon] A new coupon.
    def create_coupon(body:, **options)
      path = interpolate_path("/coupons")
      post(path, body, Requests::CouponCreate, **options)
    end

    # Fetch a coupon
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_coupon get_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Coupon] A coupon.
    def get_coupon(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      get(path, **options)
    end

    # Update an active coupon
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_coupon update_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Coupon] The updated coupon.
    def update_coupon(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate, **options)
    end

    # List unique coupon codes associated with a bulk coupon
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_unique_coupon_codes list_unique_coupon_codes api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    def list_unique_coupon_codes(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}/unique_coupon_codes", coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_credit_payments list_credit_payments api documenation}
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CreditPayment>] A list of the site's credit payments.
    def list_credit_payments(**options)
      path = interpolate_path("/credit_payments")
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_credit_payment get_credit_payment api documenation}
    #
    # @param credit_payment_id [String] Credit Payment ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::CreditPayment] A credit payment.
    def get_credit_payment(credit_payment_id:, **options)
      path = interpolate_path("/credit_payments/{credit_payment_id}", credit_payment_id: credit_payment_id)
      get(path, **options)
    end

    # List a site's custom field definitions
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_custom_field_definitions list_custom_field_definitions api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param related_type [String] Filter by related type.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CustomFieldDefinition>] A list of the site's custom field definitions.
    def list_custom_field_definitions(**options)
      path = interpolate_path("/custom_field_definitions")
      pager(path, **options)
    end

    # Fetch an custom field definition
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_custom_field_definition get_custom_field_definition api documenation}
    #
    # @param custom_field_definition_id [String] Custom Field Definition ID
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::CustomFieldDefinition] An custom field definition.
    def get_custom_field_definition(custom_field_definition_id:, **options)
      path = interpolate_path("/custom_field_definitions/{custom_field_definition_id}", custom_field_definition_id: custom_field_definition_id)
      get(path, **options)
    end

    # List a site's items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_items list_items api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Item>] A list of the site's items.
    def list_items(**options)
      path = interpolate_path("/items")
      pager(path, **options)
    end

    # Create a new item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_item create_item api documenation}
    #
    # @param body [Requests::ItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Item] A new item.
    def create_item(body:, **options)
      path = interpolate_path("/items")
      post(path, body, Requests::ItemCreate, **options)
    end

    # Fetch an item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_item get_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Item] An item.
    def get_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      get(path, **options)
    end

    # Update an active item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_item update_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param body [Requests::ItemUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Item] The updated item.
    def update_item(item_id:, body:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      put(path, body, Requests::ItemUpdate, **options)
    end

    # Deactivate an item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/deactivate_item deactivate_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Item] An item.
    def deactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      delete(path, **options)
    end

    # Reactivate an inactive item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/reactivate_item reactivate_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Item] An item.
    def reactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}/reactivate", item_id: item_id)
      put(path, **options)
    end

    # List a site's invoices
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_invoices list_invoices api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    def list_invoices(**options)
      path = interpolate_path("/invoices")
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_invoice get_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] An invoice.
    def get_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      get(path, **options)
    end

    # Update an invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/put_invoice put_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceUpdatable}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] An invoice.
    def put_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      put(path, body, Requests::InvoiceUpdatable, **options)
    end

    # Collect a pending or past due, automatic invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/collect_invoice collect_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceCollect] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCollect}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] The updated invoice.
    def collect_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/collect", invoice_id: invoice_id)
      put(path, options[:body], Requests::InvoiceCollect, **options)
    end

    # Mark an open invoice as failed
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/fail_invoice fail_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] The updated invoice.
    def fail_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_failed", invoice_id: invoice_id)
      put(path, **options)
    end

    # Mark an open invoice as successful
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/mark_invoice_successful mark_invoice_successful api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] The updated invoice.
    def mark_invoice_successful(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_successful", invoice_id: invoice_id)
      put(path, **options)
    end

    # Reopen a closed, manual invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/reopen_invoice reopen_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] The updated invoice.
    def reopen_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/reopen", invoice_id: invoice_id)
      put(path, **options)
    end

    # Void a credit invoice.
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/void_invoice void_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] The updated invoice.
    def void_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/void", invoice_id: invoice_id)
      put(path, **options)
    end

    # List an invoice's line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_invoice_line_items list_invoice_line_items api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    def list_invoice_line_items(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/line_items", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_invoice_coupon_redemptions list_invoice_coupon_redemptions api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    def list_invoice_coupon_redemptions(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/coupon_redemptions", invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_related_invoices list_related_invoices api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    def list_related_invoices(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/related_invoices", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Refund an invoice
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/refund_invoice refund_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Invoice] Returns the new credit invoice.
    def refund_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}/refund", invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund, **options)
    end

    # List a site's line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_line_items list_line_items api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    def list_line_items(**options)
      path = interpolate_path("/line_items")
      pager(path, **options)
    end

    # Fetch a line item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_line_item get_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::LineItem] A line item.
    def get_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      get(path, **options)
    end

    # Delete an uninvoiced line item
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_line_item remove_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Empty] Line item deleted.
    def remove_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      delete(path, **options)
    end

    # List a site's plans
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_plans list_plans api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Plan>] A list of plans.
    def list_plans(**options)
      path = interpolate_path("/plans")
      pager(path, **options)
    end

    # Create a plan
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_plan create_plan api documenation}
    #
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Plan] A plan.
    def create_plan(body:, **options)
      path = interpolate_path("/plans")
      post(path, body, Requests::PlanCreate, **options)
    end

    # Fetch a plan
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_plan get_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Plan] A plan.
    def get_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      get(path, **options)
    end

    # Update a plan
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_plan update_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::PlanUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Plan] A plan.
    def update_plan(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      put(path, body, Requests::PlanUpdate, **options)
    end

    # Remove a plan
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_plan remove_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Plan] Plan deleted
    def remove_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      delete(path, **options)
    end

    # List a plan's add-ons
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_plan_add_ons list_plan_add_ons api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_plan_add_ons(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_plan_add_on create_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AddOn] An add-on.
    def create_plan_add_on(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      post(path, body, Requests::AddOnCreate, **options)
    end

    # Fetch a plan's add-on
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_plan_add_on get_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AddOn] An add-on.
    def get_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      get(path, **options)
    end

    # Update an add-on
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/update_plan_add_on update_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AddOn] An add-on.
    def update_plan_add_on(plan_id:, add_on_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      put(path, body, Requests::AddOnUpdate, **options)
    end

    # Remove an add-on
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_plan_add_on remove_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AddOn] Add-on deleted
    def remove_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      delete(path, **options)
    end

    # List a site's add-ons
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_add_ons list_add_ons api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_add_ons(**options)
      path = interpolate_path("/add_ons")
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_add_on get_add_on api documenation}
    #
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::AddOn] An add-on.
    def get_add_on(add_on_id:, **options)
      path = interpolate_path("/add_ons/{add_on_id}", add_on_id: add_on_id)
      get(path, **options)
    end

    # List a site's shipping methods
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_shipping_methods list_shipping_methods api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::ShippingMethod>] A list of the site's shipping methods.
    def list_shipping_methods(**options)
      path = interpolate_path("/shipping_methods")
      pager(path, **options)
    end

    # Fetch a shipping method
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_shipping_method get_shipping_method api documenation}
    #
    # @param id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::ShippingMethod] A shipping_method.
    def get_shipping_method(id:, **options)
      path = interpolate_path("/shipping_methods/{id}", id: id)
      get(path, **options)
    end

    # List a site's subscriptions
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_subscriptions list_subscriptions api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    #
    #   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
    #   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
    #   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    def list_subscriptions(**options)
      path = interpolate_path("/subscriptions")
      pager(path, **options)
    end

    # Create a new subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_subscription create_subscription api documenation}
    #
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A subscription.
    def create_subscription(body:, **options)
      path = interpolate_path("/subscriptions")
      post(path, body, Requests::SubscriptionCreate, **options)
    end

    # Fetch a subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_subscription get_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A subscription.
    def get_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      get(path, **options)
    end

    # Modify a subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/modify_subscription modify_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A subscription.
    def modify_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate, **options)
    end

    # Terminate a subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/terminate_subscription terminate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] An expired subscription.
    def terminate_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/cancel_subscription cancel_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionCancel] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCancel}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A canceled or failed subscription.
    def cancel_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/cancel", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionCancel, **options)
    end

    # Reactivate a canceled subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/reactivate_subscription reactivate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] An active subscription.
    def reactivate_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/reactivate", subscription_id: subscription_id)
      put(path, **options)
    end

    # Pause subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/pause_subscription pause_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionPause] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionPause}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A subscription.
    def pause_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/pause", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionPause, **options)
    end

    # Resume subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/resume_subscription resume_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Subscription] A subscription.
    def resume_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/resume", subscription_id: subscription_id)
      put(path, **options)
    end

    # Fetch a subscription's pending change
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_subscription_change get_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::SubscriptionChange] A subscription's pending change.
    def get_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      get(path, **options)
    end

    # Create a new subscription change
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_subscription_change create_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::SubscriptionChange] A subscription change.
    def create_subscription_change(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate, **options)
    end

    # Delete the pending subscription change
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/remove_subscription_change remove_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Empty] Subscription change was deleted.
    def remove_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      delete(path, **options)
    end

    # List a subscription's invoices
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_subscription_invoices list_subscription_invoices api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    def list_subscription_invoices(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/invoices", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription's line items
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_subscription_line_items list_subscription_line_items api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::LineItem>] A list of the subscription's line items.
    def list_subscription_line_items(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/line_items", subscription_id: subscription_id)
      pager(path, **options)
    end

    # Show the coupon redemptions for a subscription
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_subscription_coupon_redemptions list_subscription_coupon_redemptions api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
    #   * The +ids+ parameter cannot be used with any other ordering or filtering
    #     parameters (+limit+, +order+, +sort+, +begin_time+, +end_time+, etc)
    #   * Invalid or unknown IDs will be ignored, so you should check that the
    #     results correspond to your request.
    #   * Records are returned in an arbitrary order. Since results are all
    #     returned at once you can sort the records yourself.
    #
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
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on a subscription.
    def list_subscription_coupon_redemptions(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/coupon_redemptions", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a site's transactions
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/list_transactions list_transactions api documenation}
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
    #   commas as separators, e.g. +ids=h1at4d57xlmy,gyqgg0d3v9n1,jrsm5b4yefg6+.
    #
    #   *Important notes:*
    #
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
    # @param type [String] Filter by type field. The value +payment+ will return both +purchase+ and +capture+ transactions.
    # @param success [String] Filter by success field.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    def list_transactions(**options)
      path = interpolate_path("/transactions")
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_transaction get_transaction api documenation}
    #
    # @param transaction_id [String] Transaction ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::Transaction] A transaction.
    def get_transaction(transaction_id:, **options)
      path = interpolate_path("/transactions/{transaction_id}", transaction_id: transaction_id)
      get(path, **options)
    end

    # Fetch a unique coupon code
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/get_unique_coupon_code get_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def get_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      get(path, **options)
    end

    # Deactivate a unique coupon code
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/deactivate_unique_coupon_code deactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def deactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      delete(path, **options)
    end

    # Restore a unique coupon code
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/reactivate_unique_coupon_code reactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def reactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}/restore", unique_coupon_code_id: unique_coupon_code_id)
      put(path, **options)
    end

    # Create a new purchase
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/create_purchase create_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::InvoiceCollection] Returns the new invoices
    def create_purchase(body:, **options)
      path = interpolate_path("/purchases")
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # Preview a new purchase
    #
    # {https://developers.recurly.com/api/v2999-01-01#operation/preview_purchase preview_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @return [Resources::InvoiceCollection] Returns preview of the new invoices
    def preview_purchase(body:, **options)
      path = interpolate_path("/purchases/preview")
      post(path, body, Requests::PurchaseCreate, **options)
    end
  end
end
