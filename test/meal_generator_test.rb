require "minitest/autorun"
require_relative "test_helper"

class MealGeneratorTest < MiniTest::Test
  def test_it_should_generate_a_meal_with_a_carb_and_a_protein
    current_meals = []
    returned_meal = MealPlanner::MealGenerator.generate(current_meals)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.protein)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.carb)
  end
end
