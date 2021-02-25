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
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_sites list_sites api documenation}
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
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   sites = @client.list_sites(params: params)
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
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_site get_site api documenation}
    #
    # @param site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    # @param params [Hash] Optional query string parameters:
    #
    # @return [Resources::Site] A site.
    # @example
    #   begin
    #     site = @client.get_site(site_id: site_id)
    #     puts "Got Site #{site}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_site(site_id:, **options)
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path, **options)
    end

    # List a site's accounts
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_accounts list_accounts api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   accounts = @client.list_accounts(params: params)
    #   accounts.each do |account|
    #     puts "Account: #{account.code}"
    #   end
    #
    def list_accounts(**options)
      path = interpolate_path("/accounts")
      pager(path, **options)
    end

    # Create an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_account create_account api documenation}
    #
    # @param body [Requests::AccountCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     account_create = {
    #       code: account_code,
    #       first_name: "Benjamin",
    #       last_name: "Du Monde",
    #       acquisition: {
    #         campaign: "podcast-marketing",
    #         channel: "social_media",
    #         subchannel: "twitter",
    #         cost: {
    #           currency: "USD",
    #           amount: 0.50
    #         }
    #       },
    #       shipping_addresses: [
    #         {
    #           nickname: "Home",
    #           street1: "1 Tchoupitoulas St",
    #           city: "New Orleans",
    #           region: "LA",
    #           country: "US",
    #           postal_code: "70115",
    #           first_name: "Benjamin",
    #           last_name: "Du Monde"
    #         }
    #       ]
    #     }
    #     account = @client.create_account(body: account_create)
    #     puts "Created Account #{account}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_account(body:, **options)
      path = interpolate_path("/accounts")
      post(path, body, Requests::AccountCreate, **options)
    end

    # Fetch an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account get_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      get(path, **options)
    end

    # Update an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_account update_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def update_account(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      put(path, body, Requests::AccountUpdate, **options)
    end

    # Deactivate an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_account deactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def deactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}", account_id: account_id)
      delete(path, **options)
    end

    # Fetch an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_acquisition get_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      get(path, **options)
    end

    # Update an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_account_acquisition update_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::AccountAcquisitionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountAcquisitionUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::AccountAcquisition] An account's updated acquisition data.
    # @example
    #   begin
    #     acquisition_update = {
    #       campaign: "podcast-marketing",
    #       channel: "social_media",
    #       subchannel: "twitter",
    #       cost: {
    #         currency: "USD",
    #         amount: 0.50
    #       }
    #     }
    #     acquisition = @client.update_account_acquisition(
    #       account_id: account_id,
    #       body: acquisition_update
    #     )
    #     puts "Updated AccountAcqusition #{acquisition}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def update_account_acquisition(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      put(path, body, Requests::AccountAcquisitionUpdate, **options)
    end

    # Remove an account's acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_account_acquisition remove_account_acquisition api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Acquisition data was succesfully deleted.
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
    def remove_account_acquisition(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/acquisition", account_id: account_id)
      delete(path, **options)
    end

    # Reactivate an inactive account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_account reactivate_account api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def reactivate_account(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/reactivate", account_id: account_id)
      put(path, **options)
    end

    # Fetch an account's balance and past due status
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_balance get_account_balance api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_account_balance(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/balance", account_id: account_id)
      get(path, **options)
    end

    # Fetch an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_billing_info get_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      get(path, **options)
    end

    # Set an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_billing_info update_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def update_billing_info(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      put(path, body, Requests::BillingInfoCreate, **options)
    end

    # Remove an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_billing_info remove_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Billing information deleted
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
    def remove_billing_info(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_info", account_id: account_id)
      delete(path, **options)
    end

    # Get the list of billing information associated with an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_billing_infos list_billing_infos api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::BillingInfo>] A list of the the billing information for an account's
    #
    def list_billing_infos(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos", account_id: account_id)
      pager(path, **options)
    end

    # Set an account's billing information when the wallet feature is enabled
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_billing_info create_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::BillingInfo] Updated billing information.
    #
    def create_billing_info(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos", account_id: account_id)
      post(path, body, Requests::BillingInfoCreate, **options)
    end

    # Fetch a billing info
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_a_billing_info get_a_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::BillingInfo] A billing info.
    #
    def get_a_billing_info(account_id:, billing_info_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      get(path, **options)
    end

    # Update an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_a_billing_info update_a_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID.
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::BillingInfo] Updated billing information.
    #
    def update_a_billing_info(account_id:, billing_info_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      put(path, body, Requests::BillingInfoCreate, **options)
    end

    # Remove an account's billing information
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_a_billing_info remove_a_billing_info api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param billing_info_id [String] Billing Info ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Billing information deleted
    #
    def remove_a_billing_info(account_id:, billing_info_id:, **options)
      path = interpolate_path("/accounts/{account_id}/billing_infos/{billing_info_id}", account_id: account_id, billing_info_id: billing_info_id)
      delete(path, **options)
    end

    # Show the coupon redemptions for an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_coupon_redemptions list_account_coupon_redemptions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   redemptions = @client.list_account_coupon_redemptions(
    #     account_id: account_id,
    #     params: params
    #   )
    #   redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_account_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions", account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemptions that are active on an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_active_coupon_redemptions list_active_coupon_redemptions api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CouponRedemption>] Active coupon redemptions on an account.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   redemptions = @client.list_active_coupon_redemptions(account_id: account_id, params: params)
    #   redemptions.each do |redemption|
    #     puts "Redemption: #{redemption.id}"
    #   end
    #
    def list_active_coupon_redemptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      pager(path, **options)
    end

    # Generate an active coupon redemption on an account or subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_coupon_redemption create_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::CouponRedemptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponRedemptionCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_coupon_redemption(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      post(path, body, Requests::CouponRedemptionCreate, **options)
    end

    # Delete the active coupon redemption from an account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_coupon_redemption remove_coupon_redemption api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def remove_coupon_redemption(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/coupon_redemptions/active", account_id: account_id)
      delete(path, **options)
    end

    # List an account's credit payments
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_credit_payments list_account_credit_payments api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CreditPayment>] A list of the account's credit payments.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   payments = @client.list_account_credit_payments(
    #     account_id: account_id,
    #     params: params
    #   )
    #   payments.each do |payment|
    #     puts "CreditPayment: #{payment.id}"
    #   end
    #
    def list_account_credit_payments(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/credit_payments", account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_invoices list_account_invoices api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   invoices = @client.list_account_invoices(
    #     account_id: account_id,
    #     params: params
    #   )
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_account_invoices(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_invoice create_invoice api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # Preview new invoice for pending line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_invoice preview_invoice api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def preview_invoice(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/invoices/preview", account_id: account_id)
      post(path, body, Requests::InvoiceCreate, **options)
    end

    # List an account's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_line_items list_account_line_items api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   line_items = @client.list_account_line_items(
    #     account_id: account_id,
    #     params: params
    #   )
    #   line_items.each do |line_item|
    #     puts "LineItem: #{line_item.id}"
    #   end
    #
    def list_account_line_items(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_line_item create_line_item api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_line_item(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/line_items", account_id: account_id)
      post(path, body, Requests::LineItemCreate, **options)
    end

    # Fetch a list of an account's notes
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_notes list_account_notes api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   account_notes = @client.list_account_notes(account_id: account_id, params: params)
    #   account_notes.each do |note|
    #     puts "AccountNote: #{note.message}"
    #   end
    #
    def list_account_notes(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes", account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_account_note get_account_note api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param account_note_id [String] Account Note ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_account_note(account_id:, account_note_id:, **options)
      path = interpolate_path("/accounts/{account_id}/notes/{account_note_id}", account_id: account_id, account_note_id: account_note_id)
      get(path, **options)
    end

    # Fetch a list of an account's shipping addresses
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_shipping_addresses list_shipping_addresses api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   shipping_addresses = @client.list_shipping_addresses(
    #     account_id: account_id,
    #     params: params
    #   )
    #   shipping_addresses.each do |addr|
    #     puts "ShippingAddress: #{addr.nickname} - #{addr.street1}"
    #   end
    #
    def list_shipping_addresses(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_shipping_address create_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param body [Requests::ShippingAddressCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ShippingAddress] Returns the new shipping address.
    # @example
    #   begin
    #     shipping_address_create = {
    #       nickname: 'Work',
    #       street1: '900 Camp St',
    #       city: 'New Orleans',
    #       region: 'LA',
    #       country: 'US',
    #       postal_code: '70115',
    #       first_name: 'Joanna',
    #       last_name: 'Du Monde'
    #     }
    #     shipping_address = @client.create_shipping_address(account_id: account_id, body: shipping_address_create)
    #     puts "Created Shipping Address #{shipping_address}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def create_shipping_address(account_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses", account_id: account_id)
      post(path, body, Requests::ShippingAddressCreate, **options)
    end

    # Fetch an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_shipping_address get_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      get(path, **options)
    end

    # Update an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_shipping_address update_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def update_shipping_address(account_id:, shipping_address_id:, body:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate, **options)
    end

    # Remove an account's shipping address
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_shipping_address remove_shipping_address api documenation}
    #
    # @param account_id [String] Account ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-bob+.
    # @param shipping_address_id [String] Shipping Address ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Shipping address deleted.
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
    def remove_shipping_address(account_id:, shipping_address_id:, **options)
      path = interpolate_path("/accounts/{account_id}/shipping_addresses/{shipping_address_id}", account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path, **options)
    end

    # List an account's subscriptions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_subscriptions list_account_subscriptions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   subscriptions = @client.list_account_subscriptions(
    #     account_id: account_id,
    #     params: params
    #   )
    #   subscriptions.each do |subscription|
    #     puts "Subscription: #{subscription.uuid}"
    #   end
    #
    def list_account_subscriptions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/subscriptions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_transactions list_account_transactions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   transactions = @client.list_account_transactions(
    #     account_id: account_id,
    #     params: params
    #   )
    #   transactions.each do |transaction|
    #     puts "Transaction: #{transaction.uuid}"
    #   end
    #
    def list_account_transactions(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/transactions", account_id: account_id)
      pager(path, **options)
    end

    # List an account's child accounts
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_child_accounts list_child_accounts api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Account>] A list of an account's child accounts.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   child_accounts = @client.list_child_accounts(
    #     account_id: account_id,
    #     params: params
    #   )
    #   child_accounts.each do |child|
    #     puts "Account: #{child.code}"
    #   end
    #
    def list_child_accounts(account_id:, **options)
      path = interpolate_path("/accounts/{account_id}/accounts", account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_account_acquisition list_account_acquisition api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::AccountAcquisition>] A list of the site's account acquisition data.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   acquisitions = @client.list_account_acquisition(params: params)
    #   acquisitions.each do |acquisition|
    #     puts "AccountAcquisition: #{acquisition.cost}"
    #   end
    #
    def list_account_acquisition(**options)
      path = interpolate_path("/acquisitions")
      pager(path, **options)
    end

    # List a site's coupons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_coupons list_coupons api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   coupons = @client.list_coupons(params: params)
    #   coupons.each do |coupon|
    #     puts "coupon: #{coupon.code}"
    #   end
    #
    def list_coupons(**options)
      path = interpolate_path("/coupons")
      pager(path, **options)
    end

    # Create a new coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_coupon create_coupon api documenation}
    #
    # @param body [Requests::CouponCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_coupon(body:, **options)
      path = interpolate_path("/coupons")
      post(path, body, Requests::CouponCreate, **options)
    end

    # Fetch a coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_coupon get_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_coupon(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      get(path, **options)
    end

    # Update an active coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_coupon update_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Coupon] The updated coupon.
    # @example
    #   begin
    #     coupon_update = {
    #       name: "New Coupon Name"
    #     }
    #     coupon = @client.update_coupon(coupon_id: coupon_id, body: coupon_update)
    #     puts "Updated Coupon #{coupon}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def update_coupon(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate, **options)
    end

    # Expire a coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_coupon deactivate_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Coupon] The expired Coupon
    # @example
    #   begin
    #     coupon = @client.deactivate_coupon(coupon_id: coupon_id)
    #     puts "Deactivated Coupon #{coupon}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def deactivate_coupon(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}", coupon_id: coupon_id)
      delete(path, **options)
    end

    # Generate unique coupon codes
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/generate_unique_coupon_codes generate_unique_coupon_codes api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponBulkCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponBulkCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::UniqueCouponCodeParams] A set of parameters that can be passed to the `list_unique_coupon_codes` endpoint to obtain only the newly generated `UniqueCouponCodes`.
    #
    def generate_unique_coupon_codes(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}/generate", coupon_id: coupon_id)
      post(path, body, Requests::CouponBulkCreate, **options)
    end

    # Restore an inactive coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/restore_coupon restore_coupon api documenation}
    #
    # @param coupon_id [String] Coupon ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-10off+.
    # @param body [Requests::CouponUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CouponUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Coupon] The restored coupon.
    #
    def restore_coupon(coupon_id:, body:, **options)
      path = interpolate_path("/coupons/{coupon_id}/restore", coupon_id: coupon_id)
      put(path, body, Requests::CouponUpdate, **options)
    end

    # List unique coupon codes associated with a bulk coupon
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_unique_coupon_codes list_unique_coupon_codes api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    #
    def list_unique_coupon_codes(coupon_id:, **options)
      path = interpolate_path("/coupons/{coupon_id}/unique_coupon_codes", coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_credit_payments list_credit_payments api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CreditPayment>] A list of the site's credit payments.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   payments = @client.list_credit_payments(params: params)
    #   payments.each do |payment|
    #     puts "CreditPayment: #{payment.id}"
    #   end
    #
    def list_credit_payments(**options)
      path = interpolate_path("/credit_payments")
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_credit_payment get_credit_payment api documenation}
    #
    # @param credit_payment_id [String] Credit Payment ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::CreditPayment] A credit payment.
    #
    def get_credit_payment(credit_payment_id:, **options)
      path = interpolate_path("/credit_payments/{credit_payment_id}", credit_payment_id: credit_payment_id)
      get(path, **options)
    end

    # List a site's custom field definitions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_custom_field_definitions list_custom_field_definitions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CustomFieldDefinition>] A list of the site's custom field definitions.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   custom_fields = @client.list_custom_field_definitions(params: params)
    #   custom_fields.each do |field|
    #     puts "CustomFieldDefinition: #{field.name}"
    #   end
    #
    def list_custom_field_definitions(**options)
      path = interpolate_path("/custom_field_definitions")
      pager(path, **options)
    end

    # Fetch an custom field definition
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_custom_field_definition get_custom_field_definition api documenation}
    #
    # @param custom_field_definition_id [String] Custom Field Definition ID
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::CustomFieldDefinition] An custom field definition.
    # @example
    #   begin
    #     custom_field_definition = @client.get_custom_field_definition(
    #       custom_field_definition_id: custom_field_definition_id
    #     )
    #     puts "Got Custom Field Definition #{custom_field_definition}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_custom_field_definition(custom_field_definition_id:, **options)
      path = interpolate_path("/custom_field_definitions/{custom_field_definition_id}", custom_field_definition_id: custom_field_definition_id)
      get(path, **options)
    end

    # List a site's items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_items list_items api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Item>] A list of the site's items.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   items = @client.list_items(params: params)
    #   items.each do |item|
    #     puts "Item: #{item.code}"
    #   end
    #
    def list_items(**options)
      path = interpolate_path("/items")
      pager(path, **options)
    end

    # Create a new item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_item create_item api documenation}
    #
    # @param body [Requests::ItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Item] A new item.
    # @example
    #   begin
    #     item_create = {
    #       code: item_code,
    #       name: "Item Name",
    #       description: "Item Description",
    #       external_sku: "a35JE-44",
    #       accounting_code: "item-code-127",
    #       revenue_schedule_type: "at_range_end",
    #       custom_fields: [{
    #         name: "custom-field-1",
    #         value: "Custom Field 1 value"
    #       }]
    #     }
    #     item = @client.create_item(body: item_create)
    #     puts "Created Item #{item}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def create_item(body:, **options)
      path = interpolate_path("/items")
      post(path, body, Requests::ItemCreate, **options)
    end

    # Fetch an item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_item get_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Item] An item.
    # @example
    #   begin
    #     item = @client.get_item(item_id: item_id)
    #     puts "Got Item #{item}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      get(path, **options)
    end

    # Update an active item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_item update_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param body [Requests::ItemUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ItemUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Item] The updated item.
    # @example
    #   begin
    #     item_update = {
    #       name: "New Item Name",
    #       description: "New Item Description"
    #     }
    #     item = @client.update_item(
    #       item_id: item_id,
    #       body: item_update
    #     )
    #     puts "Updated Item #{item}"
    #   rescue Recurly::Errors::ValidationError => e
    #     # If the request was invalid, you may want to tell your user
    #     # why. You can find the invalid params and reasons in e.recurly_error.params
    #     puts "ValidationError: #{e.recurly_error.params}"
    #   end
    #
    def update_item(item_id:, body:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      put(path, body, Requests::ItemUpdate, **options)
    end

    # Deactivate an item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_item deactivate_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Item] An item.
    # @example
    #   begin
    #     item = @client.deactivate_item(item_id: item_id)
    #     puts "Deactivated Item #{item}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def deactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}", item_id: item_id)
      delete(path, **options)
    end

    # Reactivate an inactive item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_item reactivate_item api documenation}
    #
    # @param item_id [String] Item ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-red+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Item] An item.
    # @example
    #   begin
    #     item = @client.reactivate_item(item_id: item_id)
    #     puts "Reactivated Item #{item}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def reactivate_item(item_id:, **options)
      path = interpolate_path("/items/{item_id}/reactivate", item_id: item_id)
      put(path, **options)
    end

    # List a site's measured units
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_measured_unit list_measured_unit api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::MeasuredUnit>] A list of the site's measured units.
    #
    def list_measured_unit(**options)
      path = interpolate_path("/measured_units")
      pager(path, **options)
    end

    # Create a new measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_measured_unit create_measured_unit api documenation}
    #
    # @param body [Requests::MeasuredUnitCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::MeasuredUnitCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::MeasuredUnit] A new measured unit.
    #
    def create_measured_unit(body:, **options)
      path = interpolate_path("/measured_units")
      post(path, body, Requests::MeasuredUnitCreate, **options)
    end

    # Fetch a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_measured_unit get_measured_unit api documenation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::MeasuredUnit] An item.
    #
    def get_measured_unit(measured_unit_id:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      get(path, **options)
    end

    # Update a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_measured_unit update_measured_unit api documenation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param body [Requests::MeasuredUnitUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::MeasuredUnitUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::MeasuredUnit] The updated measured_unit.
    #
    def update_measured_unit(measured_unit_id:, body:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      put(path, body, Requests::MeasuredUnitUpdate, **options)
    end

    # Remove a measured unit
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_measured_unit remove_measured_unit api documenation}
    #
    # @param measured_unit_id [String] Measured unit ID or name. For ID no prefix is used e.g. +e28zov4fw0v2+. For name use prefix +name-+, e.g. +name-Storage+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::MeasuredUnit] A measured unit.
    #
    def remove_measured_unit(measured_unit_id:, **options)
      path = interpolate_path("/measured_units/{measured_unit_id}", measured_unit_id: measured_unit_id)
      delete(path, **options)
    end

    # List a site's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoices list_invoices api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   invoices = @client.list_invoices(params: params)
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_invoices(**options)
      path = interpolate_path("/invoices")
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_invoice get_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      get(path, **options)
    end

    # Update an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_invoice update_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Invoice] An invoice.
    # @example
    #   begin
    #     invoice_update = {
    #       customer_notes: "New Notes",
    #       terms_and_conditions: "New Terms and Conditions"
    #     }
    #     invoice = @client.update_invoice(invoice_id: invoice_id, body: invoice_update)
    #     puts "Updated invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def update_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}", invoice_id: invoice_id)
      put(path, body, Requests::InvoiceUpdate, **options)
    end

    # Fetch an invoice as a PDF
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_invoice_pdf get_invoice_pdf api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::BinaryFile] An invoice as a PDF.
    # @example
    #   begin
    #     invoice = @client.get_invoice_pdf(invoice_id: invoice_id)
    #     puts "Got invoice #{invoice}"
    #     filename = "#{download_directory}/rubyinvoice-#{invoice_id}.pdf"
    #     IO.write(filename, invoice.data)
    #     puts "Saved Invoice PDF to #{filename}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_invoice_pdf(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}.pdf", invoice_id: invoice_id)
      get(path, **options)
    end

    # Collect a pending or past due, automatic invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/collect_invoice collect_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :body [Requests::InvoiceCollect] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCollect}
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def collect_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/collect", invoice_id: invoice_id)
      put(path, options[:body], Requests::InvoiceCollect, **options)
    end

    # Mark an open invoice as failed
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/mark_invoice_failed mark_invoice_failed api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.mark_invoice_failed(invoice_id: invoice_id)
    #     puts "Failed invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def mark_invoice_failed(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_failed", invoice_id: invoice_id)
      put(path, **options)
    end

    # Mark an open invoice as successful
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/mark_invoice_successful mark_invoice_successful api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def mark_invoice_successful(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/mark_successful", invoice_id: invoice_id)
      put(path, **options)
    end

    # Reopen a closed, manual invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reopen_invoice reopen_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def reopen_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/reopen", invoice_id: invoice_id)
      put(path, **options)
    end

    # Void a credit invoice.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/void_invoice void_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Invoice] The updated invoice.
    # @example
    #   begin
    #     invoice = @client.void_invoice(invoice_id: invoice_id)
    #     puts "Voided invoice #{invoice}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def void_invoice(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/void", invoice_id: invoice_id)
      put(path, **options)
    end

    # Record an external payment for a manual invoices.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/record_external_transaction record_external_transaction api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::ExternalTransaction] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ExternalTransaction}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Transaction] The recorded transaction.
    #
    def record_external_transaction(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}/transactions", invoice_id: invoice_id)
      post(path, body, Requests::ExternalTransaction, **options)
    end

    # List an invoice's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_line_items list_invoice_line_items api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   line_items = @client.list_invoice_line_items(
    #     invoice_id: invoice_id,
    #     params: params
    #   )
    #   line_items.each do |line_item|
    #     puts "Line Item: #{line_item.id}"
    #   end
    #
    def list_invoice_line_items(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/line_items", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_invoice_coupon_redemptions list_invoice_coupon_redemptions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   coupon_redemptions = @client.list_invoice_coupon_redemptions(
    #     invoice_id: invoice_id,
    #     params: params
    #   )
    #   coupon_redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_invoice_coupon_redemptions(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/coupon_redemptions", invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_related_invoices list_related_invoices api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   invoices = @client.list_related_invoices(
    #     invoice_id: invoice_id,
    #     params: params
    #   )
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_related_invoices(invoice_id:, **options)
      path = interpolate_path("/invoices/{invoice_id}/related_invoices", invoice_id: invoice_id)
      pager(path, **options)
    end

    # Refund an invoice
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/refund_invoice refund_invoice api documenation}
    #
    # @param invoice_id [String] Invoice ID or number. For ID no prefix is used e.g. +e28zov4fw0v2+. For number use prefix +number-+, e.g. +number-1000+.
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def refund_invoice(invoice_id:, body:, **options)
      path = interpolate_path("/invoices/{invoice_id}/refund", invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund, **options)
    end

    # List a site's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_line_items list_line_items api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   line_items = @client.list_line_items(
    #     params: params
    #   )
    #   line_items.each do |line_item|
    #     puts "LineItem: #{line_item.id}"
    #   end
    #
    def list_line_items(**options)
      path = interpolate_path("/line_items")
      pager(path, **options)
    end

    # Fetch a line item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_line_item get_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      get(path, **options)
    end

    # Delete an uninvoiced line item
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_line_item remove_line_item api documenation}
    #
    # @param line_item_id [String] Line Item ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Line item deleted.
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
    def remove_line_item(line_item_id:, **options)
      path = interpolate_path("/line_items/{line_item_id}", line_item_id: line_item_id)
      delete(path, **options)
    end

    # List a site's plans
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_plans list_plans api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Plan>] A list of plans.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   plans = @client.list_plans(params: params)
    #   plans.each do |plan|
    #     puts "Plan: #{plan.code}"
    #   end
    #
    def list_plans(**options)
      path = interpolate_path("/plans")
      pager(path, **options)
    end

    # Create a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_plan create_plan api documenation}
    #
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_plan(body:, **options)
      path = interpolate_path("/plans")
      post(path, body, Requests::PlanCreate, **options)
    end

    # Fetch a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_plan get_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      get(path, **options)
    end

    # Update a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_plan update_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::PlanUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Plan] A plan.
    # @example
    #   begin
    #     plan_update = {
    #       name: "Monthly Kombucha Subscription"
    #     }
    #     plan = @client.update_plan(plan_id: plan_id, body: plan_update)
    #     puts "Updated plan #{plan}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def update_plan(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      put(path, body, Requests::PlanUpdate, **options)
    end

    # Remove a plan
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_plan remove_plan api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Plan] Plan deleted
    # @example
    #   begin
    #     plan = @client.remove_plan(plan_id: plan_id)
    #     puts "Removed plan #{plan}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_plan(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}", plan_id: plan_id)
      delete(path, **options)
    end

    # List a plan's add-ons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_plan_add_ons list_plan_add_ons api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   add_ons = @client.list_plan_add_ons(
    #     plan_id: plan_id,
    #     params: params
    #   )
    #   add_ons.each do |add_on|
    #     puts "AddOn: #{add_on.code}"
    #   end
    #
    def list_plan_add_ons(plan_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_plan_add_on create_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::AddOn] An add-on.
    # @example
    #   begin
    #     new_add_on = {
    #       code: 'coffee_grinder',
    #       name: 'A quality grinder for your beans',
    #       default_quantity: 1,
    #       currencies: [
    #         {
    #           currency: 'USD',
    #           unit_amount: 10_000
    #         }
    #       ]
    #     }
    #     add_on = @client.create_plan_add_on(plan_id: plan_id, body: new_add_on)
    #     puts "Created plan add-on #{add_on}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def create_plan_add_on(plan_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons", plan_id: plan_id)
      post(path, body, Requests::AddOnCreate, **options)
    end

    # Fetch a plan's add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_plan_add_on get_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      get(path, **options)
    end

    # Update an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_plan_add_on update_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::AddOnUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::AddOn] An add-on.
    # @example
    #   begin
    #     add_on_update = {
    #       name: "A quality grinder for your finest beans"
    #     }
    #     add_on = @client.update_plan_add_on(
    #       plan_id: plan_id,
    #       add_on_id: add_on_id,
    #       body: add_on_update
    #     )
    #     puts "Updated add-on #{add_on}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def update_plan_add_on(plan_id:, add_on_id:, body:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      put(path, body, Requests::AddOnUpdate, **options)
    end

    # Remove an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_plan_add_on remove_plan_add_on api documenation}
    #
    # @param plan_id [String] Plan ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::AddOn] Add-on deleted
    # @example
    #   begin
    #     add_on = @client.remove_plan_add_on(
    #       plan_id: plan_id,
    #       add_on_id: add_on_id
    #     )
    #     puts "Removed add-on #{add_on}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def remove_plan_add_on(plan_id:, add_on_id:, **options)
      path = interpolate_path("/plans/{plan_id}/add_ons/{add_on_id}", plan_id: plan_id, add_on_id: add_on_id)
      delete(path, **options)
    end

    # List a site's add-ons
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_add_ons list_add_ons api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   add_ons = @client.list_add_ons(
    #     params: params
    #   )
    #   add_ons.each do |add_on|
    #     puts "AddOn: #{add_on.code}"
    #   end
    #
    def list_add_ons(**options)
      path = interpolate_path("/add_ons")
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_add_on get_add_on api documenation}
    #
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::AddOn] An add-on.
    # @example
    #   begin
    #     add_on = @client.get_add_on(add_on_id: add_on_id)
    #     puts "Got add-on #{add_on}"
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_add_on(add_on_id:, **options)
      path = interpolate_path("/add_ons/{add_on_id}", add_on_id: add_on_id)
      get(path, **options)
    end

    # List a site's shipping methods
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_shipping_methods list_shipping_methods api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::ShippingMethod>] A list of the site's shipping methods.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   shipping_methods = @client.list_shipping_methods(
    #     params: params
    #   )
    #   shipping_methods.each do |shipping_method|
    #     puts "Shipping Method: #{shipping_method.code}"
    #   end
    #
    def list_shipping_methods(**options)
      path = interpolate_path("/shipping_methods")
      pager(path, **options)
    end

    # Create a new shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_shipping_method create_shipping_method api documenation}
    #
    # @param body [Requests::ShippingMethodCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingMethodCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ShippingMethod] A new shipping method.
    #
    def create_shipping_method(body:, **options)
      path = interpolate_path("/shipping_methods")
      post(path, body, Requests::ShippingMethodCreate, **options)
    end

    # Fetch a shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_shipping_method get_shipping_method api documenation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ShippingMethod] A shipping method.
    #
    def get_shipping_method(shipping_method_id:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      get(path, **options)
    end

    # Update an active Shipping Method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_shipping_method update_shipping_method api documenation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param body [Requests::ShippingMethodUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingMethodUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ShippingMethod] The updated shipping method.
    #
    def update_shipping_method(shipping_method_id:, body:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      put(path, body, Requests::ShippingMethodUpdate, **options)
    end

    # Deactivate a shipping method
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_shipping_method deactivate_shipping_method api documenation}
    #
    # @param shipping_method_id [String] Shipping Method ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-usps_2-day+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ShippingMethod] A shipping method.
    #
    def deactivate_shipping_method(shipping_method_id:, **options)
      path = interpolate_path("/shipping_methods/{shipping_method_id}", shipping_method_id: shipping_method_id)
      delete(path, **options)
    end

    # List a site's subscriptions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscriptions list_subscriptions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   subscriptions = @client.list_subscriptions(params: params)
    #   subscriptions.each do |subscription|
    #     puts "Subscription: #{subscription.uuid}"
    #   end
    #
    def list_subscriptions(**options)
      path = interpolate_path("/subscriptions")
      pager(path, **options)
    end

    # Create a new subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_subscription create_subscription api documenation}
    #
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_subscription(body:, **options)
      path = interpolate_path("/subscriptions")
      post(path, body, Requests::SubscriptionCreate, **options)
    end

    # Fetch a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_subscription get_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      get(path, **options)
    end

    # Update a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_subscription update_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     subscription_update = {
    #       customer_notes: "New Notes",
    #       terms_and_conditions: "New ToC"
    #     }
    #     subscription = @client.update_subscription(
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
    def update_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate, **options)
    end

    # Terminate a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/terminate_subscription terminate_subscription api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
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
      path = interpolate_path("/subscriptions/{subscription_id}", subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/cancel_subscription cancel_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :body [Requests::SubscriptionCancel] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCancel}
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def cancel_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/cancel", subscription_id: subscription_id)
      put(path, options[:body], Requests::SubscriptionCancel, **options)
    end

    # Reactivate a canceled subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_subscription reactivate_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def reactivate_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/reactivate", subscription_id: subscription_id)
      put(path, **options)
    end

    # Pause subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/pause_subscription pause_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionPause] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionPause}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def pause_subscription(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/pause", subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionPause, **options)
    end

    # Resume subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/resume_subscription resume_subscription api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def resume_subscription(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/resume", subscription_id: subscription_id)
      put(path, **options)
    end

    # Convert trial subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/convert_trial convert_trial api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Subscription] A subscription.
    #
    def convert_trial(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/convert_trial", subscription_id: subscription_id)
      put(path, **options)
    end

    # Fetch a subscription's pending change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_subscription_change get_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      get(path, **options)
    end

    # Create a new subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_subscription_change create_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_subscription_change(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate, **options)
    end

    # Delete the pending subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_subscription_change remove_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Subscription change was deleted.
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
    def remove_subscription_change(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change", subscription_id: subscription_id)
      delete(path, **options)
    end

    # Preview a new subscription change
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_subscription_change preview_subscription_change api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::SubscriptionChange] A subscription change.
    #
    def preview_subscription_change(subscription_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/change/preview", subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate, **options)
    end

    # List a subscription's invoices
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_invoices list_subscription_invoices api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   invoices = @client.list_subscription_invoices(
    #     subscription_id: subscription_id,
    #     params: params
    #   )
    #   invoices.each do |invoice|
    #     puts "Invoice: #{invoice.number}"
    #   end
    #
    def list_subscription_invoices(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/invoices", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription's line items
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_line_items list_subscription_line_items api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::LineItem>] A list of the subscription's line items.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   line_items = @client.list_subscription_line_items(
    #     subscription_id: subscription_id,
    #     params: params
    #   )
    #   line_items.each do |line_item|
    #     puts "LineItem: #{line_item.id}"
    #   end
    #
    def list_subscription_line_items(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/line_items", subscription_id: subscription_id)
      pager(path, **options)
    end

    # Show the coupon redemptions for a subscription
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_subscription_coupon_redemptions list_subscription_coupon_redemptions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on a subscription.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   coupon_redemptions = @client.list_subscription_coupon_redemptions(
    #     subscription_id: subscription_id,
    #     params: params
    #   )
    #   coupon_redemptions.each do |redemption|
    #     puts "CouponRedemption: #{redemption.id}"
    #   end
    #
    def list_subscription_coupon_redemptions(subscription_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/coupon_redemptions", subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a subscription add-on's usage records
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_usage list_usage api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Usage>] A list of the subscription add-on's usage records.
    #
    def list_usage(subscription_id:, add_on_id:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/add_ons/{add_on_id}/usage", subscription_id: subscription_id, add_on_id: add_on_id)
      pager(path, **options)
    end

    # Log a usage record on this subscription add-on
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_usage create_usage api documenation}
    #
    # @param subscription_id [String] Subscription ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param add_on_id [String] Add-on ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-gold+.
    # @param body [Requests::UsageCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::UsageCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Usage] The created usage record.
    #
    def create_usage(subscription_id:, add_on_id:, body:, **options)
      path = interpolate_path("/subscriptions/{subscription_id}/add_ons/{add_on_id}/usage", subscription_id: subscription_id, add_on_id: add_on_id)
      post(path, body, Requests::UsageCreate, **options)
    end

    # Get a usage record
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_usage get_usage api documenation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Usage] The usage record.
    #
    def get_usage(usage_id:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      get(path, **options)
    end

    # Update a usage record
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/update_usage update_usage api documenation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param body [Requests::UsageCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::UsageCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Usage] The updated usage record.
    #
    def update_usage(usage_id:, body:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      put(path, body, Requests::UsageCreate, **options)
    end

    # Delete a usage record.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/remove_usage remove_usage api documenation}
    #
    # @param usage_id [String] Usage Record ID.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::Empty] Usage was successfully deleted.
    #
    def remove_usage(usage_id:, **options)
      path = interpolate_path("/usage/{usage_id}", usage_id: usage_id)
      delete(path, **options)
    end

    # List a site's transactions
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/list_transactions list_transactions api documenation}
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
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    # @example
    #   params = {
    #     limit: 200
    #   }
    #   transactions = @client.list_transactions(params: params)
    #   transactions.each do |transaction|
    #     puts "Transaction: #{transaction.uuid}"
    #   end
    #
    def list_transactions(**options)
      path = interpolate_path("/transactions")
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_transaction get_transaction api documenation}
    #
    # @param transaction_id [String] Transaction ID or UUID. For ID no prefix is used e.g. +e28zov4fw0v2+. For UUID use prefix +uuid-+, e.g. +uuid-123457890+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def get_transaction(transaction_id:, **options)
      path = interpolate_path("/transactions/{transaction_id}", transaction_id: transaction_id)
      get(path, **options)
    end

    # Fetch a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_unique_coupon_code get_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def get_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      get(path, **options)
    end

    # Deactivate a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/deactivate_unique_coupon_code deactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def deactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}", unique_coupon_code_id: unique_coupon_code_id)
      delete(path, **options)
    end

    # Restore a unique coupon code
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/reactivate_unique_coupon_code reactivate_unique_coupon_code api documenation}
    #
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code. For ID no prefix is used e.g. +e28zov4fw0v2+. For code use prefix +code-+, e.g. +code-abc-8dh2-def+.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    #
    def reactivate_unique_coupon_code(unique_coupon_code_id:, **options)
      path = interpolate_path("/unique_coupon_codes/{unique_coupon_code_id}/restore", unique_coupon_code_id: unique_coupon_code_id)
      put(path, **options)
    end

    # Create a new purchase
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/create_purchase create_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def create_purchase(body:, **options)
      path = interpolate_path("/purchases")
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # Preview a new purchase
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/preview_purchase preview_purchase api documenation}
    #
    # @param body [Requests::PurchaseCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PurchaseCreate}
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
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
    def preview_purchase(body:, **options)
      path = interpolate_path("/purchases/preview")
      post(path, body, Requests::PurchaseCreate, **options)
    end

    # List the dates that have an available export to download.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_export_dates get_export_dates api documenation}
    #
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ExportDates] Returns a list of dates.
    # @example
    #   begin
    #     export_dates = @client.get_export_dates()
    #     export_dates.dates.each do |date|
    #       puts "Exports are available for: #{date}"
    #     end
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_export_dates(**options)
      path = interpolate_path("/export_dates")
      get(path, **options)
    end

    # List of the export files that are available to download.
    #
    # {https://developers.recurly.com/api/v2021-02-25#operation/get_export_files get_export_files api documenation}
    #
    # @param export_date [String] Date for which to get a list of available automated export files. Date must be in YYYY-MM-DD format.
    # @param params [Hash] Optional query string parameters:
    #        :site_id [String] Site ID or subdomain. For ID no prefix is used e.g. +e28zov4fw0v2+. For subdomain use prefix +subdomain-+, e.g. +subdomain-recurly+.
    #
    # @return [Resources::ExportFiles] Returns a list of export files to download.
    # @example
    #   begin
    #     export_files = @client.get_export_files(export_date: export_date)
    #     export_files.files.each do |file|
    #       puts "Export file download URL: #{file.href}"
    #     end
    #   rescue Recurly::Errors::NotFoundError
    #     # If the resource was not found, you may want to alert the user or
    #     # just return nil
    #     puts "Resource Not Found"
    #   end
    #
    def get_export_files(export_date:, **options)
      path = interpolate_path("/export_dates/{export_date}/export_files", export_date: export_date)
      get(path, **options)
    end
  end
end
