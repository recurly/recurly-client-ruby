# frozen_string_literal: true

module Recurly
  # Represents a Plan in Recurly
  class Plan < Recurly::Model
    def self.list(params:)
      client.list_plans(params: params)
    end

    def self.get(id:)
      client.get_plan(plan_id: id)
    end
  end
end
