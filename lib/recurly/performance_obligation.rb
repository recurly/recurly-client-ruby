module Recurly
  class PerformanceObligation < Resource

    define_attribute_methods %w(
      id
      name
      created_at
      updated_at
    )

    def self.collection_path
      "performance_obligations"
    end
  end
end