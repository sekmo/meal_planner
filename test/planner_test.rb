require "minitest/autorun"
require_relative "test_helper"

class PlannerTest < MiniTest::Test
  def test_it_should_generate_a_plan_without_repeated_meals
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))
    max_weekly_ingredient_frequency_rule = JSON.parse(read_fixture("conf/max_weekly_ingredient_frequency_rule.json"), symbolize_names: true)
    meal_blocklist = JSON.parse(read_fixture("conf/meal_blocklist.json"), symbolize_names: true)

    planner = MealPlanner::Planner.new(ingredients_book, max_weekly_ingredient_frequency_rule, meal_blocklist)
    planner.generate_plan
    planner.print

    generated_meals = planner.meals
    generated_meals.each do |meal|
      refute generated_meals.count(meal) > 1
    end
  end
end
