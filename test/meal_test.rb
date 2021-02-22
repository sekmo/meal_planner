require "minitest/autorun"
require_relative "test_helper"

class MealTest < MiniTest::Test
  def test_can_add_ingredient
    meal = MealPlanner::Meal.new
    ingredient = MealPlanner::Ingredient.new(name: "Salmon", quantity_for_lunch: 100, quantity_for_dinner: 80)
    meal.add_ingredient(ingredient)
    assert_equal(ingredient, meal.ingredients.first)
  end

  def test_two_meals_are_the_same_if_their_ingredients_are_the_same
    meal_1 = MealPlanner::Meal.new
    meal_2 = MealPlanner::Meal.new
    salmon = MealPlanner::Ingredient.new(name: "Salmon", quantity_for_lunch: 100, quantity_for_dinner: 80)
    lettuce = MealPlanner::Ingredient.new(name: "Lettuce", quantity_for_lunch: 140, quantity_for_dinner: 90)
    meal_1.add_ingredient(salmon)
    meal_1.add_ingredient(lettuce)

    meal_2.add_ingredient(lettuce)
    meal_2.add_ingredient(salmon)

    assert_equal(meal_1, meal_2)
  end
end
