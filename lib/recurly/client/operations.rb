# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  class Client

    def api_version
      "v2021-02-25"
    end

  
    # List sites
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_sites list_sites api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::Site>] A list of sites.
    #
    def list_sites(**options)
      path = "/sites"
      pager(path, **options)
    end

    # Fetch a site
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_site get_site api documentation}
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Site] A site.
    #
    def get_site(site_id:, **options)
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path, **options)
    end

    # List a site's accounts
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_accounts list_accounts api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :email [String] Filter for accounts with this exact email address. A blank value will return accounts with both +null+ and +""+ email addresses. Note that multiple accounts can share one email address.
    #        :subscriber [Boolean] Filter for accounts with or without a subscription in the +active+,
#   +canceled+, or +future+ state.
#   
    #        :past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    #
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    #
    def list_accounts(**options)
      path = "/accounts"
      pager(path, **options)
    end

    # Create an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_account create_account api documentation}
    #
    # @param body [Requests::AccountCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Account] An account.
    #
    def create_account(body:, **options)
      path = "/accounts"
      post(path, body, Requests::AccountCreate, **options)
    end

    # Fetch an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account get_account api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Account] An account.
    #
    def get_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      get(path, **options)
    end

    # Update an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_account update_account api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Account] An account.
    #
    def update_account(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      put(path, body, Requests::AccountUpdate, **options)
    end

    # Deactivate an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_account deactivate_account api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Account] An account.
    #
    def deactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      delete(path, **options)
    end

    # Fetch an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_acquisition get_account_acquisition api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AccountAcquisition] An account's acquisition data.
    #
    def get_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      get(path, **options)
    end

    # Update an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_account_acquisition update_account_acquisition api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountAcquisitionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountAcquisitionUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AccountAcquisition] An account's updated acquisition data.
    #
    def update_account_acquisition(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      put(path, body, Requests::AccountAcquisitionUpdate, **options)
    end

    # Remove an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_account_acquisition remove_account_acquisition api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Acquisition data was succesfully deleted.
    #
    def remove_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      delete(path, **options)
    end

    # Reactivate an inactive account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_account reactivate_account api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Account] An account.
    #
    def reactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/reactivate", account_id: account_id)
      put(path, **options)
    end

    # Fetch an account's balance and past due status
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_balance get_account_balance api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AccountBalance] An account's balance.
    #
    def get_account_balance(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/balance", account_id: account_id)
      get(path, **options)
    end

    # Fetch an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_billing_info get_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BillingInfo] An account's billing information.
    #
    def get_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      get(path, **options)
    end

    # Set an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_billing_info update_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BillingInfo] Updated billing information.
    #
    def update_billing_info(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      put(path, body, Requests::BillingInfoCreate, **options)
    end

    # Remove an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_billing_info remove_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Billing information deleted
    #
    def remove_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      delete(path, **options)
    end

    # Verify an account's credit card billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/verify_billing_info verify_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :body [Requests::BillingInfoVerify] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoVerify}
    #
    # @return [Resources::Transaction] Transaction information from verify.
    #
    def verify_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info/verify", account_id: account_id)
      post(path, options[:body], Requests::BillingInfoVerify, **options)
    end

    # Verify an account's credit card billing cvv
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/verify_billing_info_cvv verify_billing_info_cvv api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoVerifyCVV] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoVerifyCVV}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Transaction] Transaction information from verify.
    #
    def verify_billing_info_cvv(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info/verify_cvv", account_id: account_id)
      post(path, body, Requests::BillingInfoVerifyCVV, **options)
    end

    # Get the list of billing information associated with an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_billing_infos list_billing_infos api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::BillingInfo>] A list of the the billing information for an account's
    #
    def list_billing_infos(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos", account_id: account_id)
      pager(path, **options)
    end

    # Add new billing information on an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_billing_info create_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BillingInfo] Updated billing information.
    #
    def create_billing_info(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos", account_id: account_id)
      post(path, body, Requests::BillingInfoCreate, **options)
    end

    # Fetch a billing info
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_a_billing_info get_a_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID. Can ONLY be used for sites utilizing the Wallet feature.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BillingInfo] A billing info.
    #
    def get_a_billing_info(account_id:, billing_info_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      get(path, **options)
    end

    # Update an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_a_billing_info update_a_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID. Can ONLY be used for sites utilizing the Wallet feature.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BillingInfo] Updated billing information.
    #
    def update_a_billing_info(account_id:, billing_info_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      put(path, body, Requests::BillingInfoCreate, **options)
    end

    # Remove an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_a_billing_info remove_a_billing_info api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID. Can ONLY be used for sites utilizing the Wallet feature.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Billing information deleted
    #
    def remove_a_billing_info(account_id:, billing_info_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      delete(path, **options)
    end

    # Show the coupon redemptions for an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_coupon_redemptions list_account_coupon_redemptions api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    #
    def list_account_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions", account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemptions that are active on an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_active_coupon_redemptions list_active_coupon_redemptions api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Pager<Resources::CouponRedemption>] Active coupon redemptions on an account.
    #
    def list_active_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      pager(path, **options)
    end

    # Generate an active coupon redemption on an account or subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_coupon_redemption create_coupon_redemption api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::CouponRedemptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponRedemptionCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::CouponRedemption] Returns the new coupon redemption.
    #
    def create_coupon_redemption(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      post(path, body, Requests::CouponRedemptionCreate, **options)
    end

    # Delete the active coupon redemption from an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_coupon_redemption remove_coupon_redemption api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::CouponRedemption] Coupon redemption deleted.
    #
    def remove_coupon_redemption(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      delete(path, **options)
    end

    # List an account's credit payments
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_credit_payments list_account_credit_payments api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::CreditPayment>] A list of the account's credit payments.
    #
    def list_account_credit_payments(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/credit_payments", account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_invoices list_account_invoices api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :type [String] Filter by type when:
#   - +type=charge+, only charge invoices will be returned.
#   - +type=credit+, only credit invoices will be returned.
#   - +type=non-legacy+, only charge and credit invoices will be returned.
#   - +type=legacy+, only legacy invoices will be returned.
#   
    #
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    #
    def list_account_invoices(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_invoice create_invoice api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] Returns the new invoices.
    #
    def create_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # Preview new invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_invoice preview_invoice api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] Returns the invoice previews.
    #
    def preview_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices/preview", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # List an account's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_line_items list_account_line_items api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :original [String] Filter by original field.
    #        :state [String] Filter by state field.
    #        :type [String] Filter by type field.
    #
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    #
    def list_account_line_items(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_line_item create_line_item api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::LineItem] Returns the new line item.
    #
    def create_line_item(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      post(path, body, Requests::LineItemCreate, **options)
    end

    # Fetch a list of an account's notes
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_notes list_account_notes api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    #
    def list_account_notes(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes", account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_note get_account_note api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param account_note_id [String] Account Note ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AccountNote] An account note.
    #
    def get_account_note(account_id:, account_note_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes/{account_note_id}", account_id: account_id, account_note_id: account_note_id)
      get(path, **options)
    end

    # Fetch a list of an account's shipping addresses
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_shipping_addresses list_shipping_addresses api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    #
    def list_shipping_addresses(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_shipping_address create_shipping_address api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::ShippingAddressCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingAddress] Returns the new shipping address.
    #
    def create_shipping_address(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      post(path, body, Requests::ShippingAddressCreate, **options)
    end

    # Fetch an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_shipping_address get_shipping_address api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingAddress] A shipping address.
    #
    def get_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      get(path, **options)
    end

    # Update an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_shipping_address update_shipping_address api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingAddress] The updated shipping address.
    #
    def update_shipping_address(account_id:, shipping_address_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate, **options)
    end

    # Remove an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_shipping_address remove_shipping_address api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Shipping address deleted.
    #
    def remove_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path, **options)
    end

    # List an account's subscriptions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_subscriptions list_account_subscriptions api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
#   
#   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
#   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
#   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
#   
    #
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    #
    def list_account_subscriptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/subscriptions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_transactions list_account_transactions api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :type [String] Filter by type field. The value +payment+ will return both +purchase+ and +capture+ transactions.
    #        :success [String] Filter by success field.
    #
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    #
    def list_account_transactions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/transactions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's child accounts
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_child_accounts list_child_accounts api documentation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :email [String] Filter for accounts with this exact email address. A blank value will return accounts with both +null+ and +""+ email addresses. Note that multiple accounts can share one email address.
    #        :subscriber [Boolean] Filter for accounts with or without a subscription in the +active+,
#   +canceled+, or +future+ state.
#   
    #        :past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    #
    # @return [Pager<Resources::Account>] A list of an account's child accounts.
    #
    def list_child_accounts(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/accounts", account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_acquisition list_account_acquisition api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::AccountAcquisition>] A list of the site's account acquisition data.
    #
    def list_account_acquisition(**options)
      path = "/acquisitions"
      pager(path, **options)
    end

    # List a site's coupons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_coupons list_coupons api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    #
    def list_coupons(**options)
      path = "/coupons"
      pager(path, **options)
    end

    # Create a new coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_coupon create_coupon api documentation}
    #
    # @param body [Requests::CouponCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Coupon] A new coupon.
    #
    def create_coupon(body:, **options)
      path = "/coupons"
      post(path, body, Requests::CouponCreate, **options)
    end

    # Fetch a coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_coupon get_coupon api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Coupon] A coupon.
    #
    def get_coupon(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      get(path, **options)
    end

    # Update an active coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_coupon update_coupon api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Coupon] The updated coupon.
    #
    def update_coupon(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate, **options)
    end

    # Expire a coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_coupon deactivate_coupon api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Coupon] The expired Coupon
    #
    def deactivate_coupon(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      delete(path, **options)
    end

    # Generate unique coupon codes
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/generate_unique_coupon_codes generate_unique_coupon_codes api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponBulkCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponBulkCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::UniqueCouponCodeParams] A set of parameters that can be passed to the `list_unique_coupon_codes` endpoint to obtain only the newly generated `UniqueCouponCodes`.
    #
    def generate_unique_coupon_codes(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}/generate", coupon_id: coupon_id)
      post(path, body, Requests::CouponBulkCreate, **options)
    end

    # Restore an inactive coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/restore_coupon restore_coupon api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Coupon] The restored coupon.
    #
    def restore_coupon(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}/restore", coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate, **options)
    end

    # List unique coupon codes associated with a bulk coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_unique_coupon_codes list_unique_coupon_codes api documentation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    #
    def list_unique_coupon_codes(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}/unique_coupon_codes", coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_credit_payments list_credit_payments api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::CreditPayment>] A list of the site's credit payments.
    #
    def list_credit_payments(**options)
      path = "/credit_payments"
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_credit_payment get_credit_payment api documentation}
    #
    # @param credit_payment_id [String] Credit Payment ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::CreditPayment] A credit payment.
    #
    def get_credit_payment(credit_payment_id:, **options)
      path = interpolate_path("/credit_payments/{credit_payment_id}", credit_payment_id: credit_payment_id)
      get(path, **options)
    end

    # List a site's custom field definitions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_custom_field_definitions list_custom_field_definitions api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :related_type [String] Filter by related type.
    #
    # @return [Pager<Resources::CustomFieldDefinition>] A list of the site's custom field definitions.
    #
    def list_custom_field_definitions(**options)
      path = "/custom_field_definitions"
      pager(path, **options)
    end

    # Fetch an custom field definition
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_custom_field_definition get_custom_field_definition api documentation}
    #
    # @param custom_field_definition_id [String] Custom Field Definition ID
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::CustomFieldDefinition] An custom field definition.
    #
    def get_custom_field_definition(custom_field_definition_id:, **options)
      path = interpolate_path("/custom_field_definitions/{custom_field_definition_id}", custom_field_definition_id: custom_field_definition_id)
      get(path, **options)
    end

    # List an invoice template's associated accounts
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_template_accounts list_invoice_template_accounts api documentation}
    #
    # @param invoice_template_id [String] Invoice template ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :email [String] Filter for accounts with this exact email address. A blank value will return accounts with both +null+ and +""+ email addresses. Note that multiple accounts can share one email address.
    #        :subscriber [Boolean] Filter for accounts with or without a subscription in the +active+,
#   +canceled+, or +future+ state.
#   
    #        :past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    #
    # @return [Pager<Resources::Account>] A list of an invoice template's associated accounts.
    #
    def list_invoice_template_accounts(invoice_template_id:, **options)
      path = interpolate_path("/invoice_templates/{invoice_template_id}/accounts", invoice_template_id: invoice_template_id)
      pager(path, **options)
    end

    # List a site's items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_items list_items api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::Item>] A list of the site's items.
    #
    def list_items(**options)
      path = "/items"
      pager(path, **options)
    end

    # Create a new item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_item create_item api documentation}
    #
    # @param body [Requests::ItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Item] A new item.
    #
    def create_item(body:, **options)
      path = "/items"
      post(path, body, Requests::ItemCreate, **options)
    end

    # Fetch an item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_item get_item api documentation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Item] An item.
    #
    def get_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      get(path, **options)
    end

    # Update an active item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_item update_item api documentation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param body [Requests::ItemUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Item] The updated item.
    #
    def update_item(item_id:, body:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      put(path, body, Requests::ItemUpdate, **options)
    end

    # Deactivate an item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_item deactivate_item api documentation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Item] An item.
    #
    def deactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      delete(path, **options)
    end

    # Reactivate an inactive item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_item reactivate_item api documentation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Item] An item.
    #
    def reactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}/reactivate", item_id: item_id)
      put(path, **options)
    end

    # List a site's measured units
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_measured_unit list_measured_unit api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::MeasuredUnit>] A list of the site's measured units.
    #
    def list_measured_unit(**options)
      path = "/measured_units"
      pager(path, **options)
    end

    # Create a new measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_measured_unit create_measured_unit api documentation}
    #
    # @param body [Requests::MeasuredUnitCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::MeasuredUnitCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::MeasuredUnit] A new measured unit.
    #
    def create_measured_unit(body:, **options)
      path = "/measured_units"
      post(path, body, Requests::MeasuredUnitCreate, **options)
    end

    # Fetch a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_measured_unit get_measured_unit api documentation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::MeasuredUnit] An item.
    #
    def get_measured_unit(measured_unit_id:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      get(path, **options)
    end

    # Update a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_measured_unit update_measured_unit api documentation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param body [Requests::MeasuredUnitUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::MeasuredUnitUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::MeasuredUnit] The updated measured_unit.
    #
    def update_measured_unit(measured_unit_id:, body:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      put(path, body, Requests::MeasuredUnitUpdate, **options)
    end

    # Remove a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_measured_unit remove_measured_unit api documentation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::MeasuredUnit] A measured unit.
    #
    def remove_measured_unit(measured_unit_id:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      delete(path, **options)
    end

    # List a site's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoices list_invoices api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :type [String] Filter by type when:
#   - +type=charge+, only charge invoices will be returned.
#   - +type=credit+, only credit invoices will be returned.
#   - +type=non-legacy+, only charge and credit invoices will be returned.
#   - +type=legacy+, only legacy invoices will be returned.
#   
    #
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    #
    def list_invoices(**options)
      path = "/invoices"
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_invoice get_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] An invoice.
    #
    def get_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      get(path, **options)
    end

    # Update an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_invoice update_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] An invoice.
    #
    def update_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      put(path, body, Requests::InvoiceUpdate, **options)
    end

    # Fetch an invoice as a PDF
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_invoice_pdf get_invoice_pdf api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::BinaryFile] An invoice as a PDF.
    #
    def get_invoice_pdf(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}.pdf", invoice_id: invoice_id)
      get(path, **options)
    end

    # Collect a pending or past due, automatic invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/collect_invoice collect_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :body [Requests::InvoiceCollect] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCollect}
    #
    # @return [Resources::Invoice] The updated invoice.
    #
    def collect_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/collect", invoice_id: invoice_id)
      put(path, options[:body], Requests::InvoiceCollect, **options)
    end

    # Mark an open invoice as failed
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/mark_invoice_failed mark_invoice_failed api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] The updated invoice.
    #
    def mark_invoice_failed(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_failed", invoice_id: invoice_id)
      put(path, **options)
    end

    # Mark an open invoice as successful
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/mark_invoice_successful mark_invoice_successful api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] The updated invoice.
    #
    def mark_invoice_successful(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_successful", invoice_id: invoice_id)
      put(path, **options)
    end

    # Reopen a closed, manual invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reopen_invoice reopen_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] The updated invoice.
    #
    def reopen_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/reopen", invoice_id: invoice_id)
      put(path, **options)
    end

    # Void a credit invoice.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/void_invoice void_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] The updated invoice.
    #
    def void_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/void", invoice_id: invoice_id)
      put(path, **options)
    end

    # Record an external payment for a manual invoices.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/record_external_transaction record_external_transaction api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::ExternalTransaction] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ExternalTransaction}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Transaction] The recorded transaction.
    #
    def record_external_transaction(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}/transactions", invoice_id: invoice_id)
      post(path, body, Requests::ExternalTransaction, **options)
    end

    # List an invoice's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_line_items list_invoice_line_items api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :original [String] Filter by original field.
    #        :state [String] Filter by state field.
    #        :type [String] Filter by type field.
    #
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    #
    def list_invoice_line_items(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/line_items", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_coupon_redemptions list_invoice_coupon_redemptions api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    #
    def list_invoice_coupon_redemptions(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/coupon_redemptions", invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_related_invoices list_related_invoices api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    #
    def list_related_invoices(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/related_invoices", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Refund an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/refund_invoice refund_invoice api documentation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Invoice] Returns the new credit invoice.
    #
    def refund_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}/refund", invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund, **options)
    end

    # List a site's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_line_items list_line_items api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :original [String] Filter by original field.
    #        :state [String] Filter by state field.
    #        :type [String] Filter by type field.
    #
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    #
    def list_line_items(**options)
      path = "/line_items"
      pager(path, **options)
    end

    # Fetch a line item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_line_item get_line_item api documentation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::LineItem] A line item.
    #
    def get_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      get(path, **options)
    end

    # Delete an uninvoiced line item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_line_item remove_line_item api documentation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Line item deleted.
    #
    def remove_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      delete(path, **options)
    end

    # List a site's plans
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_plans list_plans api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::Plan>] A list of plans.
    #
    def list_plans(**options)
      path = "/plans"
      pager(path, **options)
    end

    # Create a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_plan create_plan api documentation}
    #
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Plan] A plan.
    #
    def create_plan(body:, **options)
      path = "/plans"
      post(path, body, Requests::PlanCreate, **options)
    end

    # Fetch a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_plan get_plan api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Plan] A plan.
    #
    def get_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      get(path, **options)
    end

    # Update a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_plan update_plan api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::PlanUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Plan] A plan.
    #
    def update_plan(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      put(path, body, Requests::PlanUpdate, **options)
    end

    # Remove a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_plan remove_plan api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Plan] Plan deleted
    #
    def remove_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      delete(path, **options)
    end

    # List a plan's add-ons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_plan_add_ons list_plan_add_ons api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    #
    def list_plan_add_ons(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_plan_add_on create_plan_add_on api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AddOn] An add-on.
    #
    def create_plan_add_on(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      post(path, body, Requests::AddOnCreate, **options)
    end

    # Fetch a plan's add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_plan_add_on get_plan_add_on api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AddOn] An add-on.
    #
    def get_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      get(path, **options)
    end

    # Update an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_plan_add_on update_plan_add_on api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AddOn] An add-on.
    #
    def update_plan_add_on(plan_id:, add_on_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      put(path, body, Requests::AddOnUpdate, **options)
    end

    # Remove an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_plan_add_on remove_plan_add_on api documentation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AddOn] Add-on deleted
    #
    def remove_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      delete(path, **options)
    end

    # List a site's add-ons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_add_ons list_add_ons api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
    #
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    #
    def list_add_ons(**options)
      path = "/add_ons"
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_add_on get_add_on api documentation}
    #
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::AddOn] An add-on.
    #
    def get_add_on(add_on_id:, **options)
      path = interpolate_path("/add_ons/{add_on_id}", add_on_id: add_on_id)
      get(path, **options)
    end

    # List a site's shipping methods
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_shipping_methods list_shipping_methods api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::ShippingMethod>] A list of the site's shipping methods.
    #
    def list_shipping_methods(**options)
      path = "/shipping_methods"
      pager(path, **options)
    end

    # Create a new shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_shipping_method create_shipping_method api documentation}
    #
    # @param body [Requests::ShippingMethodCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingMethodCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingMethod] A new shipping method.
    #
    def create_shipping_method(body:, **options)
      path = "/shipping_methods"
      post(path, body, Requests::ShippingMethodCreate, **options)
    end

    # Fetch a shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_shipping_method get_shipping_method api documentation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingMethod] A shipping method.
    #
    def get_shipping_method(shipping_method_id:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      get(path, **options)
    end

    # Update an active Shipping Method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_shipping_method update_shipping_method api documentation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param body [Requests::ShippingMethodUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingMethodUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingMethod] The updated shipping method.
    #
    def update_shipping_method(shipping_method_id:, body:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      put(path, body, Requests::ShippingMethodUpdate, **options)
    end

    # Deactivate a shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_shipping_method deactivate_shipping_method api documentation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ShippingMethod] A shipping method.
    #
    def deactivate_shipping_method(shipping_method_id:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      delete(path, **options)
    end

    # List a site's subscriptions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscriptions list_subscriptions api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :state [String] Filter by state.
#   
#   - When +state=active+, +state=canceled+, +state=expired+, or +state=future+, subscriptions with states that match the query and only those subscriptions will be returned.
#   - When +state=in_trial+, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned.
#   - When +state=live+, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
#   
    #
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    #
    def list_subscriptions(**options)
      path = "/subscriptions"
      pager(path, **options)
    end

    # Create a new subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_subscription create_subscription api documentation}
    #
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def create_subscription(body:, **options)
      path = "/subscriptions"
      post(path, body, Requests::SubscriptionCreate, **options)
    end

    # Fetch a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_subscription get_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def get_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      get(path, **options)
    end

    # Update a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_subscription update_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def update_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate, **options)
    end

    # Terminate a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/terminate_subscription terminate_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :refund [String] The type of refund to perform:
#   
#   * +full+ - Performs a full refund of the last invoice for the current subscription term.
#   * +partial+ - Prorates a refund based on the amount of time remaining in the current bill cycle.
#   * +none+ - Terminates the subscription without a refund.
#   
#   In the event that the most recent invoice is a $0 invoice paid entirely by credit, Recurly will apply the credit back to the customer’s account.
#   
#   You may also terminate a subscription with no refund and then manually refund specific invoices.
#   
    #        :charge [Boolean] Applicable only if the subscription has usage based add-ons and unbilled usage logged for the current billing cycle. If true, current billing cycle unbilled usage is billed on the final invoice. If false, Recurly will create a negative usage record for current billing cycle usage that will zero out the final invoice line items.
    #
    # @return [Resources::Subscription] An expired subscription.
    #
    def terminate_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/cancel_subscription cancel_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :body [Requests::SubscriptionCancel] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCancel}
    #
    # @return [Resources::Subscription] A canceled or failed subscription.
    #
    def cancel_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/cancel", subscription_id: subscription_id)
      put(path, options[:body], Requests::SubscriptionCancel, **options)
    end

    # Reactivate a canceled subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_subscription reactivate_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] An active subscription.
    #
    def reactivate_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/reactivate", subscription_id: subscription_id)
      put(path, **options)
    end

    # Pause subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/pause_subscription pause_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionPause] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionPause}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def pause_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/pause", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionPause, **options)
    end

    # Resume subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/resume_subscription resume_subscription api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def resume_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/resume", subscription_id: subscription_id)
      put(path, **options)
    end

    # Convert trial subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/convert_trial convert_trial api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Subscription] A subscription.
    #
    def convert_trial(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/convert_trial", subscription_id: subscription_id)
      put(path, **options)
    end

    # Fetch a preview of a subscription's renewal invoice(s)
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_preview_renewal get_preview_renewal api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] A preview of the subscription's renewal invoice(s).
    #
    def get_preview_renewal(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/preview_renewal", subscription_id: subscription_id)
      get(path, **options)
    end

    # Fetch a subscription's pending change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_subscription_change get_subscription_change api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::SubscriptionChange] A subscription's pending change.
    #
    def get_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      get(path, **options)
    end

    # Create a new subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_subscription_change create_subscription_change api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::SubscriptionChange] A subscription change.
    #
    def create_subscription_change(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate, **options)
    end

    # Delete the pending subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_subscription_change remove_subscription_change api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Subscription change was deleted.
    #
    def remove_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      delete(path, **options)
    end

    # Preview a new subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_subscription_change preview_subscription_change api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::SubscriptionChange] A subscription change.
    #
    def preview_subscription_change(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change/preview", subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate, **options)
    end

    # List a subscription's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_invoices list_subscription_invoices api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :type [String] Filter by type when:
#   - +type=charge+, only charge invoices will be returned.
#   - +type=credit+, only credit invoices will be returned.
#   - +type=non-legacy+, only charge and credit invoices will be returned.
#   - +type=legacy+, only legacy invoices will be returned.
#   
    #
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    #
    def list_subscription_invoices(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/invoices", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_line_items list_subscription_line_items api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :original [String] Filter by original field.
    #        :state [String] Filter by state field.
    #        :type [String] Filter by type field.
    #
    # @return [Pager<Resources::LineItem>] A list of the subscription's line items.
    #
    def list_subscription_line_items(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/line_items", subscription_id: subscription_id)
      pager(path, **options)
    end

    # Show the coupon redemptions for a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_coupon_redemptions list_subscription_coupon_redemptions api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on a subscription.
    #
    def list_subscription_coupon_redemptions(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/coupon_redemptions", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription add-on's usage records
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_usage list_usage api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +usage_timestamp+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=usage_timestamp+ or +sort=recorded_timestamp+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=usage_timestamp+ or +sort=recorded_timestamp+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :billing_status [String] Filter by usage record's billing status
    #
    # @return [Pager<Resources::Usage>] A list of the subscription add-on's usage records.
    #
    def list_usage(subscription_id:, add_on_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/add_ons/{add_on_id}/usage", subscription_id: subscription_id, add_on_id: add_on_id)
      pager(path, **options)
    end

    # Log a usage record on this subscription add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_usage create_usage api documentation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::UsageCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::UsageCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Usage] The created usage record.
    #
    def create_usage(subscription_id:, add_on_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/add_ons/{add_on_id}/usage", subscription_id: subscription_id, add_on_id: add_on_id)
      post(path, body, Requests::UsageCreate, **options)
    end

    # Get a usage record
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_usage get_usage api documentation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Usage] The usage record.
    #
    def get_usage(usage_id:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      get(path, **options)
    end

    # Update a usage record
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_usage update_usage api documentation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param body [Requests::UsageCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::UsageCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Usage] The updated usage record.
    #
    def update_usage(usage_id:, body:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      put(path, body, Requests::UsageCreate, **options)
    end

    # Delete a usage record.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_usage remove_usage api documentation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Empty] Usage was successfully deleted.
    #
    def remove_usage(usage_id:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      delete(path, **options)
    end

    # List a site's transactions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_transactions list_transactions api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    #        :limit [Integer] Limit number of records 1-200.
    #        :order [String] Sort order.
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #        :begin_time [DateTime] Inclusively filter by begin_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :end_time [DateTime] Inclusively filter by end_time when +sort=created_at+ or +sort=updated_at+.
#   *Note:* this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
#   
    #        :type [String] Filter by type field. The value +payment+ will return both +purchase+ and +capture+ transactions.
    #        :success [String] Filter by success field.
    #
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    #
    def list_transactions(**options)
      path = "/transactions"
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_transaction get_transaction api documentation}
    #
    # @param transaction_id [String] Transaction ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Transaction] A transaction.
    #
    def get_transaction(transaction_id:, **options)
      path = interpolate_path("/transactions/{transaction_id}", transaction_id: transaction_id)
      get(path, **options)
    end

    # Fetch a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_unique_coupon_code get_unique_coupon_code api documentation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def get_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      get(path, **options)
    end

    # Deactivate a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_unique_coupon_code deactivate_unique_coupon_code api documentation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def deactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      delete(path, **options)
    end

    # Restore a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_unique_coupon_code reactivate_unique_coupon_code api documentation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def reactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}/restore", unique_coupon_code_id: unique_coupon_code_id)
      put(path, **options)
    end

    # Create a new purchase
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_purchase create_purchase api documentation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] Returns the new invoices
    #
    def create_purchase(body:, **options)
      path = "/purchases"
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # Preview a new purchase
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_purchase preview_purchase api documentation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] Returns preview of the new invoices
    #
    def preview_purchase(body:, **options)
      path = "/purchases/preview"
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # Create a pending purchase
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_pending_purchase create_pending_purchase api documentation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceCollection] Returns the pending invoice
    #
    def create_pending_purchase(body:, **options)
      path = "/purchases/pending"
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # List the dates that have an available export to download.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_export_dates get_export_dates api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ExportDates] Returns a list of dates.
    #
    def get_export_dates(**options)
      path = "/export_dates"
      get(path, **options)
    end

    # List of the export files that are available to download.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_export_files get_export_files api documentation}
    #
    # @param export_date [String] Date for which to get a list of available automated export files. Date must be in YYYY-MM-DD format.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::ExportFiles] Returns a list of export files to download.
    #
    def get_export_files(export_date:, **options)
      path = interpolate_path("/export_dates/{export_date}/export_files", export_date: export_date)
      get(path, **options)
    end

    # Show the dunning campaigns for a site
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_dunning_campaigns list_dunning_campaigns api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #
    # @return [Pager<Resources::DunningCampaign>] A list of the the dunning_campaigns on an account.
    #
    def list_dunning_campaigns(**options)
      path = "/dunning_campaigns"
      pager(path, **options)
    end

    # Show the settings for a dunning campaign
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_dunning_campaign get_dunning_campaign api documentation}
    #
    # @param dunning_campaign_id [String] Dunning Campaign ID, e.g. +e28zov4fw0v2+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::DunningCampaign] Settings for a dunning campaign.
    #
    def get_dunning_campaign(dunning_campaign_id:, **options)
      path = interpolate_path("/dunning_campaigns/{dunning_campaign_id}", dunning_campaign_id: dunning_campaign_id)
      get(path, **options)
    end

    # Assign a dunning campaign to multiple plans
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/put_dunning_campaign_bulk_update put_dunning_campaign_bulk_update api documentation}
    #
    # @param dunning_campaign_id [String] Dunning Campaign ID, e.g. +e28zov4fw0v2+.
    # @param body [Requests::DunningCampaignsBulkUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::DunningCampaignsBulkUpdate}
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::DunningCampaignsBulkUpdateResponse] A list of updated plans.
    #
    def put_dunning_campaign_bulk_update(dunning_campaign_id:, body:, **options)
      path = interpolate_path("/dunning_campaigns/{dunning_campaign_id}/bulk_update", dunning_campaign_id: dunning_campaign_id)
      put(path, body, Requests::DunningCampaignsBulkUpdate, **options)
    end

    # Show the invoice templates for a site
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_templates list_invoice_templates api documentation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :sort [String] Sort field. You *really* only want to sort by +updated_at+ in ascending
#   order. In descending order updated records will move behind the cursor and could
#   prevent some records from being returned.
#   
    #
    # @return [Pager<Resources::InvoiceTemplate>] A list of the the invoice templates on a site.
    #
    def list_invoice_templates(**options)
      path = "/invoice_templates"
      pager(path, **options)
    end

    # Show the settings for an invoice template
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_invoice_template get_invoice_template api documentation}
    #
    # @param invoice_template_id [String] Invoice template ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::InvoiceTemplate] Settings for an invoice template.
    #
    def get_invoice_template(invoice_template_id:, **options)
      path = interpolate_path("/invoice_templates/{invoice_template_id}", invoice_template_id: invoice_template_id)
      get(path, **options)
    end
  end
end
