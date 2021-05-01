require "minitest/autorun"
require_relative "test_helper"

class MealTest < MiniTest::Test
  def test_can_be_initialized_with_ingredients_and_meal_type
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    lettuce = MealPlanner::Ingredient.new(name: "Lettuce", kind: "veggie", quantity_for_lunch: 160, quantity_for_dinner: 80)

    meal = MealPlanner::Meal.new(protein: salmon, carb: bread, veggie: lettuce, meal_type: :lunch)

    assert_equal(salmon, meal.protein)
    assert_equal(bread, meal.carb)
  end

  def test_can_set_ingredients
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    lettuce = MealPlanner::Ingredient.new(name: "Lettuce", kind: "veggie", quantity_for_lunch: 160, quantity_for_dinner: 80)

    meal = MealPlanner::Meal.new(meal_type: :lunch)
    meal.protein = salmon
    meal.carb = bread
    meal.veggie = lettuce

    assert_equal(salmon, meal.protein)
    assert_equal(bread, meal.carb)
    assert_equal(lettuce, meal.veggie)
  end

  def test_two_meals_are_the_same_if_their_ingredients_are_the_same
    meal_1 = MealPlanner::Meal.new(meal_type: :lunch)
    meal_2 = MealPlanner::Meal.new(meal_type: :dinner)
    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    lettuce = MealPlanner::Ingredient.new(name: "Lettuce", kind: "veggie", quantity_for_lunch: 160, quantity_for_dinner: 80)

    meal_1.protein = salmon
    meal_1.veggie = lettuce
    meal_1.carb = bread

    meal_2.carb = bread
    meal_2.protein = salmon
    meal_2.veggie = lettuce

    assert_equal(meal_1, meal_2)
  end

  def test_ingredient_names_should_return_the_name_of_the_ingredients
    meal_1 = MealPlanner::Meal.new(meal_type: :lunch)
    meal_2 = MealPlanner::Meal.new(meal_type: :dinner)

    salmon = MealPlanner::Ingredient.new(name: "Salmon", kind: "protein", quantity_for_lunch: 100, quantity_for_dinner: 80)
    bread = MealPlanner::Ingredient.new(name: "Bread", kind: "carb", quantity_for_lunch: 140, quantity_for_dinner: 90)
    lettuce = MealPlanner::Ingredient.new(name: "Lettuce", kind: "veggie", quantity_for_lunch: 160, quantity_for_dinner: 80)

    meal_1.protein = salmon
    meal_1.veggie = lettuce
    meal_1.carb = bread

    meal_2.carb = bread
    meal_2.protein = salmon

    assert_equal(["Bread", "Lettuce", "Salmon"], meal_1.ingredient_names)
    assert_equal(["Bread", "Salmon"], meal_2.ingredient_names)
  end
end
