require "minitest/autorun"
require_relative "test_helper"

class MealTest < MiniTest::Test
  def test_can_be_initialized_with_a_protein_and_a_carb
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    meal = MealPlanner::Meal.new(protein: salmon, carb: bread)

    assert_equal(salmon, meal.protein)
    assert_equal(bread, meal.carb)
  end

  def test_can_set_protein_and_carb
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    meal = MealPlanner::Meal.new
    meal.protein = salmon
    meal.carb = bread

    assert_equal(salmon, meal.protein)
    assert_equal(bread, meal.carb)
  end

  def test_two_meals_are_the_same_if_their_ingredients_are_the_same
    meal_1 = MealPlanner::Meal.new
    meal_2 = MealPlanner::Meal.new
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    meal_1.protein = salmon
    meal_1.carb = bread

    meal_2.carb = bread
    meal_2.protein = salmon

    assert_equal(meal_1, meal_2)
  end
end
