require "minitest/autorun"
require_relative "test_helper"

class IngredientTest < MiniTest::Test
  def test_should_be_initialized_with_name_and_quantities
    ingredient = MealPlanner::Ingredient.new(name: "Salmon", quantity_for_lunch: 100, quantity_for_dinner: 80)
    assert_equal("Salmon", ingredient.name)
    assert_equal(100, ingredient.quantity_for_lunch)
    assert_equal(80, ingredient.quantity_for_dinner)
  end
end
