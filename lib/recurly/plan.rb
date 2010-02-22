module Recurly
  class Plan < RecurlyBase
    self.element_name = "plan"
    self.prefix = "/company/"
    
    def to_param
      self.plan_code
    end
  end
end