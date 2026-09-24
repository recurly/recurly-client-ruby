# frozen_string_literal: true

module Recurly
  # Represents a MeasuredUnit in Recurly
  class MeasuredUnit < Recurly::Model
    def self.list(params:)
      client.list_measured_unit(params: params)
    end

    def self.get(id:)
      client.get_measured_unit(measured_unit_id: id)
    end
  end
end
