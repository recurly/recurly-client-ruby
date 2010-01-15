module Recurly
  class Plan < RecurlyBase
    self.element_name = "plan"
    
    def to_param
      self.plan_code
    end
  end
end