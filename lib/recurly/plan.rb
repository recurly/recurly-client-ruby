module Recurly
  class Plan < RecurlyBase
    self.element_name = "plan"
    self.prefix = "/company/"
    self.primary_key = :plan_code
  end
end