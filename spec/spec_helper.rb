require 'environment'
require 'cgi'
require 'minitest/autorun'
require 'minitest/spec'
require 'webmock'

module SpecHelper
  include WebMock::API

  def get_raw_xml fixture
    xml = File.open(File.dirname(__FILE__) + "/fixtures/" + fixture, "rb") { |f| f.read }
    return (Recurly::XML.new xml).to_s
  end

  def stub_api_request method, uri, fixture = nil
    uri = API.base_uri + uri
    uri.user = CGI.escape Recurly.api_key
    uri.password = ''
    response = if block_given?
      yield
    else
      File.read File.expand_path("../fixtures/#{fixture}.xml", __FILE__)
    end
    stub_request(method, uri.to_s).to_return response
  end
end
include SpecHelper

XML = {
  200 => {
    :index   => [
      <<EOR,
HTTP/1.1 200 OK
Link: \
<https://api.recurly.com/v2/resources?per_page=2&cursor=1234567890>; rel="next"
X-Records: 3

<resources>
<resource>
  <uuid>1</uuid>
</resource>
<resource>
  <uuid>2</uuid>
</resource>
</resources>
EOR
      <<EOR
HTTP/1.1 200 OK
Link: \
<https://api.recurly.com/v2/resources?per_page=2>; rel="start", <https://api.recurly.com/v2/resources?per_page=2&cursor=-11306277>; rel="prev"
X-Records: 3

<resources>
<resource>
  <uuid>3</uuid>
</resource>
</resources>
EOR
    ],
    :show    => <<EOR,
HTTP/1.1 200 OK

<resource>
  <name>Spock</name>
</resource>
EOR
    :update  => <<EOR,
HTTP/1.1 200 OK

<resource>
  <name>Persistent Little Bug</name>
</resource>
EOR
    :destroy => <<EOR
HTTP/1.1 200 OK
Content-Length: 0
EOR
  },
  201 => <<EOR,
HTTP/1.1 201 Created
Content-Type: application/xml; charset=utf-8

<resource>
  <name>Persistent Little Bug</name>
</resource>
EOR
  422 => <<EOR,
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/xml; charset=utf-8

<errors>
  <error field="resource.name" symbol="invalid_name">is a bad name</error>
  <error field="resource.child.name" symbol="invalid_name">is a bad name</error>
</errors>
EOR
  404 => <<EOR,
HTTP/1.1 404 Not Found
Content-Type: application/xml; charset=utf-8

<error>
  <symbol>not_found</symbol>
  <description>Resource not found</description>
</error>
EOR
}
