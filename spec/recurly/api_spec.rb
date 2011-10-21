require 'spec_helper'

describe API do
  describe "HTTP errors" do
    it "must raise exceptions" do
      API::ERRORS.each_pair do |code, exception|
        stub_api_request(:any, 'endpoint') { "HTTP/1.1 #{code}\n" }
        proc { API.get 'endpoint' }.must_raise exception
      end
    end
  end
end
