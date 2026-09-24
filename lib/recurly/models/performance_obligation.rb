# frozen_string_literal: true

module Recurly
  # Represents a PerformanceObligation in Recurly
  class PerformanceObligation < Recurly::Model
    def self.list(params:)
      client.get_performance_obligations(params: params)
    end

    def self.get(id:)
      client.get_performance_obligation(performance_obligation_id: id)
    end
  end
end
