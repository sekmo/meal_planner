require "minitest/autorun"
require_relative "test_helper"

class PlannerTest < MiniTest::Test
  def test_it_should_generate_a_plan_without_repeated_meals
    generated_meals = MealPlanner::Planner.generate_plan
    generated_meals.each do |meal|
      refute generated_meals.count(meal) > 1
    end
  end
end
