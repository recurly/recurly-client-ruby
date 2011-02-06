module ActiveResource
  class Connection

    # Get the results without decoding
    def get_raw(path, headers = {})
      with_auth { request(:get, path, build_request_headers(headers, :get, self.site.merge(path))) }
    end

  end
end