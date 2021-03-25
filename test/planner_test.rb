require "minitest/autorun"
require_relative "test_helper"

class PlannerTest < MiniTest::Test
  def test_it_should_generate_a_plan_without_repeated_meals
    ingredients = JSON.parse(File.read("conf/ingredients.json"), symbolize_names: true)
    max_weekly_ingredient_frequency_rule = JSON.parse(File.read("conf/ingredients.json"), symbolize_names: true)

    generated_meals =
      MealPlanner::Planner.generate_plan(ingredients, max_weekly_ingredient_frequency_rule)
    generated_meals.each do |meal|
      refute generated_meals.count(meal) > 1
    end
  end
end
