module ActiveResource
  class Connection

    # Get the results without decoding
    def get_raw(path, headers = {})
      request(:get, path, build_request_headers(headers, :get))
    end

  end
end
