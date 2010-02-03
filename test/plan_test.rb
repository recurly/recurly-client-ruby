require 'test_helper'

class PlanTest < Test::Unit::TestCase

  def test_list_plans
    plans = Recurly::Plan.find(:all)
    
    assert_not_nil plans
    assert_instance_of Array, plans
  end
  
  def test_get_plan
    plan = Recurly::Plan.find(TEST_PLAN_CODE)
    assert_not_nil plan
    assert_not_nil plan.name
  end

end