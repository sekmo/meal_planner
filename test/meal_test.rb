require "minitest/autorun"
require_relative "test_helper"

class MealTest < MiniTest::Test
  def test_can_add_ingredient
    meal = MealPlanner::Meal.new
    ingredient = MealPlanner::Ingredient.new(name: "Salmon", quantity_for_lunch: 100, quantity_for_dinner: 80)
    meal.add_ingredient(ingredient)
    assert_equal(ingredient, meal.ingredients.first)
  end
end
