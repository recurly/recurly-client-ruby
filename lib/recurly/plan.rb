module Recurly
  class Plan < Base
    self.element_name = "plan"
    self.primary_key = :plan_code

    def self.known_attributes
      [
        "plan_code",
        "name",
        "description",
        "success_url",
        "cancel_url",
        "created_at"
      ]
    end

  end
end