# These must be in the Recurly::Requests namespace
class Recurly::Requests::MySubRequest < Recurly::Request
  define_attribute :a_string, String
end

# These must be in the Recurly::Requests namespace
class Recurly::Requests::MyRequest < Recurly::Request
  define_attribute :a_string, String
  define_attribute :a_hash, Hash
  define_attribute :an_integer, Integer
  define_attribute :a_float, Float
  define_attribute :a_boolean, :Boolean
  define_attribute :a_datetime, DateTime
  define_attribute :a_string_array, Array, item_type: String

  # Sub Requests
  define_attribute :a_sub_request, :MySubRequest
  define_attribute :a_sub_request_array, Array, item_type: :MySubRequest
end

# These must be in the Recurly::Resources namespace
class Recurly::Resources::MySubResource < Recurly::Resource
  define_attribute :a_string, String
end

# These must be in the Recurly::Resources namespace
class Recurly::Resources::MyResourceWithClient < Recurly::Resource
  attr_accessor :client
  define_attribute :a_string, String

  def requires_client?; true end
end

# These must be in the Recurly::Resources namespace
class Recurly::Resources::MyResource < Recurly::Resource
  define_attribute :a_string, String
  define_attribute :a_hash, Hash
  define_attribute :an_integer, Integer
  define_attribute :a_float, Float
  define_attribute :a_boolean, :Boolean
  define_attribute :a_datetime, DateTime
  define_attribute :a_string_array, Array, item_type: String

  # Sub Resources
  define_attribute :a_sub_resource, :MySubResource
  define_attribute :a_sub_resource_array, Array, item_type: :MySubResource

  # Special CurrencyArray
  define_attribute :pricing, Array, item_type: :MyPricing
end

# These must be in the Recurly::Resources namespace
class Recurly::Resources::MyPricing < Recurly::Resource
  define_attribute :currency, String
  define_attribute :amount, Integer
end
