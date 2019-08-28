# This file is automatically created by Recurly's OpenAPI generation process
# and thus any edits you make by hand will be lost. If you wish to make a
# change to this file, please create a Github issue explaining the changes you
# need and we will usher them to the appropriate places.
module Recurly
  class Client
    def api_version
      "v2018-08-09"
    end

    # List sites
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_sites list_sites api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @example
    #   sites = @client.list_sites(limit: 200)
    #   sites.each do |site|
    #     puts "Site: #{site.subdomain}"
    #   end
    #
    def list_sites(**options)
      path = "/sites"
      pager(path, **options)
    end

    # Fetch a site
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_site get_site api documenation}
    #
    # @return [Resources::Site] A site.
    def get_site()
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path)
    end

    # List a site's accounts
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_accounts list_accounts api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @param subscriber [Boolean] Filter accounts with or without a subscription in the +active+,
    #   +canceled+, or +future+ state.
    #
    # @param past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    # @example
    #   accounts = @client.list_accounts(limit: 200)
    #   accounts.each do |account|
    #     puts "Account: #{account.code}"
    #   end
    #
    def list_accounts(**options)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      pager(path, **options)
    end

    # Create an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_account create_account api documenation}
    #
    # @param body [Requests::AccountCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountCreate}
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account_create = {
    #       code: account_code,
    #       first_name: "Benjamin",
    #       last_name: "Du Monde",
    #     }
    #     account = @client.create_account(body: account_create)
    #     puts "Created Account #{account}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_account(body:)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      post(path, body, Requests::AccountCreate)
    end

    # Fetch an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_account get_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account = @client.get_account(account_id: account_id)
    #     puts "Got Account #{account}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Modify an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_account update_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::AccountUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdate}
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account_update = {
    #       first_name: "Aaron",
    #       last_name: "Du Monde",
    #     }
    #     account = @client.update_account(
    #       account_id: account_id,
    #       body: account_update
    #     )
    #     puts "Updated Account #{account}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def update_account(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      put(path, body, Requests::AccountUpdate)
    end

    # Deactivate an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/deactivate_account deactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account = @client.deactivate_account(account_id: account_id)
    #     puts "Deactivated Account #{account}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def deactivate_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Fetch an account's acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_account_acquisition get_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::AccountAcquisition] An account's acquisition data.
    # @example
    #   begin
    #     @client.get_account_acquisition(account_id: account_id)
    #     puts "Got AccountAcquisition"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_account_acquisition(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Update an account's acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_account_acquisition update_account_acquisition api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_account_acquisition remove_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Empty] Acquisition data was succesfully deleted.
    # @example
    #   begin
    #     acquisition = @client.remove_account_acquisition(account_id: account_id)
    #     puts "Removed AccountAcqusition #{acquisition}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_account_acquisition(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Reactivate an inactive account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/reactivate_account reactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account = @client.reactivate_account(account_id: account_id)
    #     puts "Reactivated account #{account}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def reactivate_account(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/reactivate", site_id: site_id, account_id: account_id)
      put(path)
    end

    # Fetch an account's balance and past due status
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_account_balance get_account_balance api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::AccountBalance] An account's balance.
    # @example
    #   begin
    #     balance = @client.get_account_balance(account_id: account_id)
    #     puts "Got AccountBalance #{balance}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_account_balance(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/balance", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Fetch an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_billing_info get_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::BillingInfo] An account's billing information.
    # @example
    #   begin
    #     billing = @client.get_billing_info(account_id: account_id)
    #     puts "Got BillingInfo #{billing}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_billing_info(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Set an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_billing_info update_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @return [Resources::BillingInfo] Updated billing information.
    # @example
    #   begin
    #     billing_update = {
    #       first_name: "Aaron",
    #       last_name: "Du Monde",
    #     }
    #     billing = @client.update_billing_info(
    #       account_id: account_id,
    #       body: billing_update
    #     )
    #     puts "Updated BillingInfo #{billing}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def update_billing_info(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      put(path, body, Requests::BillingInfoCreate)
    end

    # Remove an account's billing information
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_billing_info remove_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Empty] Billing information deleted
    # @example
    #   begin
    #     @client.remove_billing_info(account_id: account_id)
    #     puts "Removed BillingInfo #{account_id}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_billing_info(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Show the coupon redemptions for an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_coupon_redemptions list_account_coupon_redemptions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    # @example
    #   redemptions = @client.list_account_coupon_redemptions(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_account_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemption that is active on an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_active_coupon_redemption get_active_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::CouponRedemption] An active coupon redemption on an account.
    # @example
    #   begin
    #     redemption = @client.get_active_coupon_redemption(account_id: account_id)
    #     puts "Got CouponRedemption #{redemption}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_active_coupon_redemption(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Generate an active coupon redemption on an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_coupon_redemption create_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::CouponRedemptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponRedemptionCreate}
    # @return [Resources::CouponRedemption] Returns the new coupon redemption.
    # @example
    #   begin
    #     redemption_create = {
    #       currency: 'USD',
    #       coupon_id: coupon_id
    #     }
    #     redemption = @client.create_coupon_redemption(
    #       account_id: account_id,
    #       body: redemption_create
    #     )
    #     puts "Created CouponRedemption #{redemption}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_coupon_redemption(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      post(path, body, Requests::CouponRedemptionCreate)
    end

    # Delete the active coupon redemption from an account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_coupon_redemption remove_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @return [Resources::CouponRedemption] Coupon redemption deleted.
    # @example
    #   begin
    #     @client.remove_coupon_redemption(account_id: account_id)
    #     puts "Removed CouponRedemption #{account_id}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_coupon_redemption(account_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # List an account's credit payments
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_credit_payments list_account_credit_payments api documenation}
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
    # @example
    #   payments = @client.list_account_credit_payments(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   payments.each do |payment|
    #     puts "CreditPayment: #{payment.id}"
    #   end
    #
    def list_account_credit_payments(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/credit_payments", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_invoices list_account_invoices api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    # @example
    #   invoices = @client.list_account_invoices(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_account_invoices(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_invoice create_invoice api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @return [Resources::InvoiceCollection] Returns the new invoices.
    # @example
    #   begin
    #     invoice_create = {
    #       currency: 'USD',
    #       collection_method: 'automatic'
    #     }
    #     collection = @client.create_invoice(
    #       account_id: account_id,
    #       body: invoice_create
    #     )
    #     puts "Created InvoiceCollection #{collection}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_invoice(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # Preview new invoice for pending line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/preview_invoice preview_invoice api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @return [Resources::InvoiceCollection] Returns the invoice previews.
    # @example
    #   begin
    #     invoice_preview = {
    #       currency: "USD",
    #       collection_method: "automatic"
    #     }
    #     collection = @client.create_invoice(
    #       account_id: account_id,
    #       body: invoice_preview
    #     )
    #     puts "Created InvoiceCollection #{collection}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def preview_invoice(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices/preview", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # List an account's line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_line_items list_account_line_items api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    # @example
    #   line_items = @client.list_account_line_items(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   line_items.each do |line_item|
    #     puts "LineItem: #{line_item.id}"
    #   end
    #
    def list_account_line_items(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_line_item create_line_item api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}
    # @return [Resources::LineItem] Returns the new line item.
    # @example
    #   begin
    #     line_item_create = {
    #       currency: 'USD',
    #       unit_amount: 1_000,
    #       type: :charge
    #     }
    #     line_item = @client.create_line_item(
    #       account_id: account_id,
    #       body: line_item_create
    #     )
    #     puts "Created LineItem #{line_item}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_line_item(account_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      post(path, body, Requests::LineItemCreate)
    end

    # Fetch a list of an account's notes
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_notes list_account_notes api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    # @example
    #   account_notes = @client.list_account_notes(account_id: account_id, limit: 200)
    #   account_notes.each do |note|
    #     puts "AccountNote: #{note.message}"
    #   end
    #
    def list_account_notes(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_account_note get_account_note api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param account_note_id [String] Account Note ID.
    # @return [Resources::AccountNote] An account note.
    # @example
    #   begin
    #     note = @client.get_account_note(
    #       account_id: account_id,
    #       account_note_id: note_id
    #     )
    #     puts "Got AccountNote #{note}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_account_note(account_id:, account_note_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes/{account_note_id}", site_id: site_id, account_id: account_id, account_note_id: account_note_id)
      get(path)
    end

    # Fetch a list of an account's shipping addresses
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_shipping_addresses list_shipping_addresses api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    # @example
    #   shipping_addresses = @client.list_shipping_addresses(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   shipping_addresses.each do |addr|
    #     puts "ShippingAddress: #{addr.nickname} - #{addr.street1}"
    #   end
    #
    def list_shipping_addresses(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_shipping_address create_shipping_address api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_shipping_address get_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    # @return [Resources::ShippingAddress] A shipping address.
    # @example
    #   begin
    #     address = @client.get_shipping_address(
    #       account_id: account_id,
    #       shipping_address_id: shipping_address_id
    #     )
    #     puts "Got ShippingAddress #{address}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_shipping_address(account_id:, shipping_address_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      get(path)
    end

    # Update an account's shipping address
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_shipping_address update_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}
    # @return [Resources::ShippingAddress] The updated shipping address.
    # @example
    #   begin
    #     address_update = {
    #       first_name: "Aaron",
    #       last_name: "Du Monde",
    #       postal_code: "70130"
    #     }
    #     address = @client.update_shipping_address(
    #       account_id: account_id,
    #       shipping_address_id: shipping_address_id,
    #       body: address_update
    #     )
    #     puts "Updated ShippingAddress #{address}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def update_shipping_address(account_id:, shipping_address_id:, body:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate)
    end

    # Remove an account's shipping address
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_shipping_address remove_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param shipping_address_id [String] Shipping Address ID.
    # @return [Empty] Shipping address deleted.
    # @example
    #   begin
    #     @client.remove_shipping_address(
    #       account_id: account_id,
    #       shipping_address_id: shipping_address_id
    #     )
    #     puts "Removed ShippingAddress #{shipping_address_id}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_shipping_address(account_id:, shipping_address_id:)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path)
    end

    # List an account's subscriptions
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_subscriptions list_account_subscriptions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    # @example
    #   subscriptions = @client.list_account_subscriptions(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   subscriptions.each do |subscription|
    #     puts "Subscription: #{subscription.uuid}"
    #   end
    #
    def list_account_subscriptions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/subscriptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_transactions list_account_transactions api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    # @example
    #   transactions = @client.list_account_transactions(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   transactions.each do |transaction|
    #     puts "Transaction: #{transaction.uuid}"
    #   end
    #
    def list_account_transactions(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/transactions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's child accounts
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_child_accounts list_child_accounts api documenation}
    #
    # @param account_id [String] Account ID or code (use prefix: +code-+, e.g. +code-bob+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @param subscriber [Boolean] Filter accounts with or without a subscription in the +active+,
    #   +canceled+, or +future+ state.
    #
    # @param past_due [String] Filter for accounts with an invoice in the +past_due+ state.
    # @return [Pager<Resources::Account>] A list of an account's child accounts.
    # @example
    #   child_accounts = @client.list_child_accounts(
    #     account_id: account_id,
    #     limit: 200
    #   )
    #   child_accounts.each do |child|
    #     puts "Account: #{child.code}"
    #   end
    #
    def list_child_accounts(account_id:, **options)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/accounts", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_account_acquisition list_account_acquisition api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::AccountAcquisition>] A list of the site's account acquisition data.
    # @example
    #   acquisitions = @client.list_account_acquisition(limit: 200)
    #   acquisitions.each do |acquisition|
    #     puts "AccountAcquisition: #{acquisition.cost}"
    #   end
    #
    def list_account_acquisition(**options)
      path = interpolate_path("/sites/{site_id}/acquisitions", site_id: site_id)
      pager(path, **options)
    end

    # List a site's coupons
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_coupons list_coupons api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    # @example
    #   coupons = @client.list_coupons(limit: 200)
    #   coupons.each do |coupon|
    #     puts "coupon: #{coupon.code}"
    #   end
    #
    def list_coupons(**options)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      pager(path, **options)
    end

    # Create a new coupon
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_coupon create_coupon api documenation}
    #
    # @param body [Requests::CouponCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponCreate}
    # @return [Resources::Coupon] A new coupon.
    # @example
    #   begin
    #     coupon_create = {
    #       name: "Promotional Coupon",
    #       code: coupon_code,
    #       discount_type: 'fixed',
    #       currencies: [
    #         {
    #           currency: 'USD',
    #           discount: 10_000
    #         }
    #       ]
    #     }
    #     coupon = @client.create_coupon(
    #       body: coupon_create
    #     )
    #     puts "Created Coupon #{coupon}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_coupon(body:)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      post(path, body, Requests::CouponCreate)
    end

    # Fetch a coupon
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_coupon get_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code (use prefix: +code-+, e.g. +code-10off+).
    # @return [Resources::Coupon] A coupon.
    # @example
    #   begin
    #     coupon = @client.get_coupon(coupon_id: coupon_id)
    #     puts "Got Coupon #{coupon}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_coupon(coupon_id:)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}", site_id: site_id, coupon_id: coupon_id)
      get(path)
    end

    # Update an active coupon
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_coupon update_coupon api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_unique_coupon_codes list_unique_coupon_codes api documenation}
    #
    # @param coupon_id [String] Coupon ID or code (use prefix: +code-+, e.g. +code-10off+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    def list_unique_coupon_codes(coupon_id:, **options)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}/unique_coupon_codes", site_id: site_id, coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_credit_payments list_credit_payments api documenation}
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
    # @example
    #   payments = @client.list_credit_payments(limit: 200)
    #   payments.each do |payment|
    #     puts "CreditPayment: #{payment.id}"
    #   end
    #
    def list_credit_payments(**options)
      path = interpolate_path("/sites/{site_id}/credit_payments", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_credit_payment get_credit_payment api documenation}
    #
    # @param credit_payment_id [String] Credit Payment ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::CreditPayment] A credit payment.
    def get_credit_payment(credit_payment_id:)
      path = interpolate_path("/sites/{site_id}/credit_payments/{credit_payment_id}", site_id: site_id, credit_payment_id: credit_payment_id)
      get(path)
    end

    # List a site's custom field definitions
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_custom_field_definitions list_custom_field_definitions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::CustomFieldDefinition>] A list of the site's custom field definitions.
    # @example
    #   custom_fields = @client.list_custom_field_definitions(limit: 200)
    #   custom_fields.each do |field|
    #     puts "CustomFieldDefinition: #{field.name}"
    #   end
    #
    def list_custom_field_definitions(**options)
      path = interpolate_path("/sites/{site_id}/custom_field_definitions", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an custom field definition
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_custom_field_definition get_custom_field_definition api documenation}
    #
    # @param custom_field_definition_id [String] Custom Field Definition ID
    # @return [Resources::CustomFieldDefinition] An custom field definition.
    def get_custom_field_definition(custom_field_definition_id:)
      path = interpolate_path("/sites/{site_id}/custom_field_definitions/{custom_field_definition_id}", site_id: site_id, custom_field_definition_id: custom_field_definition_id)
      get(path)
    end

    # List a site's invoices
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_invoices list_invoices api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    # @example
    #   invoices = @client.list_invoices(limit: 200)
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_invoices(**options)
      path = interpolate_path("/sites/{site_id}/invoices", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_invoice get_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] An invoice.
    # @example
    #   begin
    #     invoice = @client.get_invoice(invoice_id: invoice_id)
    #     puts "Got invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}", site_id: site_id, invoice_id: invoice_id)
      get(path)
    end

    # Update an invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/put_invoice put_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param body [Requests::InvoiceUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceUpdatable}
    # @return [Resources::Invoice] An invoice.
    def put_invoice(invoice_id:, body:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}", site_id: site_id, invoice_id: invoice_id)
      put(path, body, Requests::InvoiceUpdatable)
    end

    # Collect a pending or past due, automatic invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/collect_invoice collect_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.collect_invoice(invoice_id: invoice_id)
    #     puts "Collected invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def collect_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/collect", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as failed
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/fail_invoice fail_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.fail_invoice(invoice_id: invoice_id)
    #     puts "Failed invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def fail_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_failed", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as successful
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/mark_invoice_successful mark_invoice_successful api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.mark_invoice_successful(invoice_id: invoice_id)
    #     puts "Marked invoice sucessful #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def mark_invoice_successful(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_successful", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Reopen a closed, manual invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/reopen_invoice reopen_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.reopen_invoice(invoice_id: invoice_id)
    #     puts "Reopened invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def reopen_invoice(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/reopen", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # List an invoice's line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_invoice_line_items list_invoice_line_items api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    def list_invoice_line_items(invoice_id:, **options)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/line_items", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_invoice_coupon_redemptions list_invoice_coupon_redemptions api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    # @example
    #   coupon_redemptions = @client.list_invoice_coupon_redemptions(
    #     invoice_id: invoice_id,
    #     limit: 200
    #   )
    #   coupon_redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_invoice_coupon_redemptions(invoice_id:, **options)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/coupon_redemptions", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_related_invoices list_related_invoices api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    def list_related_invoices(invoice_id:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/related_invoices", site_id: site_id, invoice_id: invoice_id)
      pager(path)
    end

    # Refund an invoice
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/refund_invoice refund_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number (use prefix: +number-+, e.g. +number-1000+).
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}
    # @return [Resources::Invoice] Returns the new credit invoice.
    # @example
    #   begin
    #     invoice_refund = {
    #       type: "amount",
    #       amount: 100,
    #     }
    #     invoice = @client.refund_invoice(
    #       invoice_id: invoice_id,
    #       body: invoice_refund
    #     )
    #     puts "Refunded invoice #{invoice}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def refund_invoice(invoice_id:, body:)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/refund", site_id: site_id, invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund)
    end

    # List a site's line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_line_items list_line_items api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    def list_line_items(**options)
      path = interpolate_path("/sites/{site_id}/line_items", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a line item
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_line_item get_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @return [Resources::LineItem] A line item.
    # @example
    #   begin
    #     line_item = @client.get_line_item(line_item_id: line_item_id)
    #     puts "Got LineItem #{line_item}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_line_item(line_item_id:)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      get(path)
    end

    # Delete an uninvoiced line item
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_line_item remove_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @return [Empty] Line item deleted.
    # @example
    #   begin
    #     @client.remove_line_item(
    #       line_item_id: line_item_id
    #     )
    #     puts "Removed LineItem #{line_item_id}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_line_item(line_item_id:)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      delete(path)
    end

    # List a site's plans
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_plans list_plans api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Plan>] A list of plans.
    # @example
    #   plans = @client.list_plans(limit: 200)
    #   plans.each do |plan|
    #     puts "Plan: #{plan.code}"
    #   end
    #
    def list_plans(**options)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      pager(path, **options)
    end

    # Create a plan
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_plan create_plan api documenation}
    #
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}
    # @return [Resources::Plan] A plan.
    # @example
    #   begin
    #     plan_create = {
    #       code: plan_code,
    #       name: plan_name,
    #       currencies: [
    #         currency: "USD",
    #         setup_fee: 1_000
    #       ],
    #       add_ons: [
    #         {
    #           name: 'Extra User',
    #           code: 'extra_user',
    #           currencies: [
    #             { currency: 'USD', unit_amount: 10_000 }
    #           ]
    #         }
    #       ]
    #     }
    #     plan = @client.create_plan(body: plan_create)
    #     puts "Created Plan #{plan}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_plan(body:)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      post(path, body, Requests::PlanCreate)
    end

    # Fetch a plan
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_plan get_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::Plan] A plan.
    # @example
    #   begin
    #     plan = @client.get_plan(plan_id: plan_id)
    #     puts "Got plan #{plan}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_plan(plan_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      get(path)
    end

    # Update a plan
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_plan update_plan api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_plan remove_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::Plan] Plan deleted
    def remove_plan(plan_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      delete(path)
    end

    # List a plan's add-ons
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_plan_add_ons list_plan_add_ons api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    # @example
    #   add_ons = @client.list_plan_add_ons(
    #     plan_id: plan_id,
    #     limit: 200
    #   )
    #   add_ons.each do |add_on|
    #     puts "AddOn: #{add_on.code}"
    #   end
    #
    def list_plan_add_ons(plan_id:, **options)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons", site_id: site_id, plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_plan_add_on create_plan_add_on api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_plan_add_on get_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::AddOn] An add-on.
    # @example
    #   begin
    #     add_on = @client.get_plan_add_on(
    #       plan_id: plan_id, add_on_id: add_on_id
    #     )
    #     puts "Got plan add-on #{add_on}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_plan_add_on(plan_id:, add_on_id:)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, plan_id: plan_id, add_on_id: add_on_id)
      get(path)
    end

    # Update an add-on
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/update_plan_add_on update_plan_add_on api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_plan_add_on remove_plan_add_on api documenation}
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
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_add_ons list_add_ons api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_add_ons(**options)
      path = interpolate_path("/sites/{site_id}/add_ons", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_add_on get_add_on api documenation}
    #
    # @param add_on_id [String] Add-on ID or code (use prefix: +code-+, e.g. +code-gold+).
    # @return [Resources::AddOn] An add-on.
    def get_add_on(add_on_id:)
      path = interpolate_path("/sites/{site_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id)
      get(path)
    end

    # List a site's subscriptions
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_subscriptions list_subscriptions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    # @example
    #   subscriptions = @client.list_subscriptions(limit: 200)
    #   subscriptions.each do |subscription|
    #     puts "Subscription: #{subscription.uuid}"
    #   end
    #
    def list_subscriptions(**options)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      pager(path, **options)
    end

    # Create a new subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_subscription create_subscription api documenation}
    #
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription_create = {
    #       plan_code: plan_code,
    #       currency: "USD",
    #       # This can be an existing account or
    #       # a new acocunt
    #       account: {
    #         code: account_code,
    #       }
    #     }
    #     subscription = @client.create_subscription(
    #       body: subscription_create
    #     )
    #     puts "Created Subscription #{subscription}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_subscription(body:)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      post(path, body, Requests::SubscriptionCreate)
    end

    # Fetch a subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_subscription get_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription = @client.get_subscription(
    #       subscription_id: subscription_id
    #     )
    #     puts "Got Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Modify a subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/modify_subscription modify_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription_update = {
    #       customer_notes: "New Notes",
    #       terms_and_conditions: "New ToC"
    #     }
    #     subscription = @client.modify_subscription(
    #       subscription_id: subscription_id,
    #       body: subscription_update
    #     )
    #     puts "Modified Subscription #{subscription}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def modify_subscription(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate)
    end

    # Terminate a subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/terminate_subscription terminate_subscription api documenation}
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
    # @example
    #   begin
    #     subscription = @client.terminate_subscription(
    #       subscription_id: subscription_id,
    #     )
    #     puts "Terminated Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def terminate_subscription(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/cancel_subscription cancel_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A canceled or failed subscription.
    # @example
    #   begin
    #     subscription = @client.cancel_subscription(
    #       subscription_id: subscription_id
    #     )
    #     puts "Canceled Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def cancel_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/cancel", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Reactivate a canceled subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/reactivate_subscription reactivate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] An active subscription.
    # @example
    #   begin
    #     subscription = @client.reactivate_subscription(
    #       subscription_id: subscription_id
    #     )
    #     puts "Reactivated Canceled Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def reactivate_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/reactivate", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Pause subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/pause_subscription pause_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionPause] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionPause}
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription_pause = {
    #       remaining_pause_cycles: 10
    #     }
    #     subscription = @client.pause_subscription(
    #       subscription_id: subscription_id,
    #       body: subscription_pause
    #     )
    #     puts "Paused Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def pause_subscription(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/pause", site_id: site_id, subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionPause)
    end

    # Resume subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/resume_subscription resume_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription = @client.resume_subscription(
    #       subscription_id: subscription_id
    #     )
    #     puts "Resumed Subscription #{subscription}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def resume_subscription(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/resume", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Fetch a subscription's pending change
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_subscription_change get_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::SubscriptionChange] A subscription's pending change.
    # @example
    #   begin
    #     change = @client.get_subscription_change(
    #       subscription_id: subscription_id
    #     )
    #     puts "Got SubscriptionChange #{change}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_subscription_change(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Create a new subscription change
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_subscription_change create_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @return [Resources::SubscriptionChange] A subscription change.
    # @example
    #   begin
    #     change_create = {
    #       timeframe: "now",
    #       plan_code: new_plan_code
    #     }
    #     change = @client.create_subscription_change(
    #       subscription_id: subscription_id,
    #       body: change_create
    #     )
    #     puts "Created SubscriptionChange #{change}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_subscription_change(subscription_id:, body:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate)
    end

    # Delete the pending subscription change
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/remove_subscription_change remove_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Empty] Subscription change was deleted.
    # @example
    #   begin
    #     @client.remove_subscription_change(
    #       subscription_id: subscription_id
    #     )
    #     puts "Removed SubscriptionChange #{subscription_id}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_subscription_change(subscription_id:)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      delete(path)
    end

    # List a subscription's invoices
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_subscription_invoices list_subscription_invoices api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    # @example
    #   invoices = @client.list_subscription_invoices(
    #     subscription_id: subscription_id,
    #     limit: 200
    #   )
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_subscription_invoices(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/invoices", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription's line items
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_subscription_line_items list_subscription_line_items api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::LineItem>] A list of the subscription's line items.
    # @example
    #   line_items = @client.list_subscription_line_items(
    #     subscription_id: subscription_id,
    #     limit: 200
    #   )
    #   line_items.each do |line_item|
    #     puts "LineItem: #{line_item.id}"
    #   end
    #
    def list_subscription_line_items(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/line_items", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # Show the coupon redemptions for a subscription
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_subscription_coupon_redemptions list_subscription_coupon_redemptions api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on a subscription.
    # @example
    #   coupon_redemptions = @client.list_subscription_coupon_redemptions(
    #     subscription_id: subscription_id,
    #     limit: 200
    #   )
    #   coupon_redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_subscription_coupon_redemptions(subscription_id:, **options)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/coupon_redemptions", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a site's transactions
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/list_transactions list_transactions api documenation}
    #
    # @param ids [string] Filter results by their IDs. Up to 200 IDs can be passed at once using
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
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    # @example
    #   transactions = @client.list_transactions(limit: 200)
    #   transactions.each do |transaction|
    #     puts "Transaction: #{transaction.uuid}"
    #   end
    #
    def list_transactions(**options)
      path = interpolate_path("/sites/{site_id}/transactions", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_transaction get_transaction api documenation}
    #
    # @param transaction_id [String] Transaction ID or UUID (use prefix: +uuid-+, e.g. +uuid-123457890+).
    # @return [Resources::Transaction] A transaction.
    # @example
    #   begin
    #     transaction = @client.get_transaction(transaction_id: transaction_id)
    #     puts "Got Transaction #{transaction}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_transaction(transaction_id:)
      path = interpolate_path("/sites/{site_id}/transactions/{transaction_id}", site_id: site_id, transaction_id: transaction_id)
      get(path)
    end

    # Fetch a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/get_unique_coupon_code get_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def get_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      get(path)
    end

    # Deactivate a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/deactivate_unique_coupon_code deactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def deactivate_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      delete(path)
    end

    # Restore a unique coupon code
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/reactivate_unique_coupon_code reactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: +code-+, e.g. +code-abc-8dh2-def+).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def reactivate_unique_coupon_code(unique_coupon_code_id:)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}/restore", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      put(path)
    end

    # Create a new purchase
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/create_purchase create_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @return [Resources::InvoiceCollection] Returns the new invoices
    # @example
    #   begin
    #     purchase = {
    #       currency: "USD",
    #       account: {
    #         code: account_code,
    #         first_name: "Benjamin",
    #         last_name: "Du Monde",
    #         billing_info: {
    #           token_id: rjs_token_id
    #         },
    #       },
    #       subscriptions: [
    #         { plan_code: plan_code }
    #       ]
    #     }
    #     invoice_collection = @client.create_purchase(
    #       body: purchase
    #     )
    #     puts "Created Charge Invoice #{invoice_collection.charge_invoice}"
    #     puts "Created Credit Invoices #{invoice_collection.credit_invoices}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_purchase(body:)
      path = interpolate_path("/sites/{site_id}/purchases", site_id: site_id)
      post(path, body, Requests::PurchaseCreate)
    end

    # Preview a new purchase
    #
    # {https://partner-docs.recurly.com/v2018-08-09#operation/preview_purchase preview_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @return [Resources::InvoiceCollection] Returns preview of the new invoices
    # @example
    #   begin
    #     purchase = {
    #       currency: "USD",
    #       account: {
    #         code: account_code,
    #         first_name: "Benjamin",
    #         last_name: "Du Monde",
    #         billing_info: {
    #           token_id: rjs_token_id
    #         },
    #       },
    #       subscriptions: [
    #         { plan_code: plan_code }
    #       ]
    #     }
    #     invoice_collection = @client.preview_purchase(
    #       body: purchase
    #     )
    #     puts "Preview Charge Invoice #{invoice_collection.charge_invoice}"
    #     puts "Preview Credit Invoices #{invoice_collection.credit_invoices}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def preview_purchase(body:)
      path = interpolate_path("/sites/{site_id}/purchases/preview", site_id: site_id)
      post(path, body, Requests::PurchaseCreate)
    end
  end
end
