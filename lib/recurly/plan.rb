module Recurly
  class Plan < RecurlyBase
    self.element_name = "plan"
    self.prefix = "/company/"

    def id
      self.plan_code
    end

    def to_param
      self.plan_code
    end
  end
end