require "minitest/autorun"
require_relative "test_helper"

class IngredientBookTest < MiniTest::Test
  def test_sample_carb_should_return_a_random_carb
    current_meals = []
    1_000.times do
      assert_equal("carb", MealPlanner::IngredientBook.sample_carb(current_meals).kind)
    end
  end

  def test_sample_protein_should_return_a_random_protein
    current_meals = []
    1_000.times do
      assert_equal("protein", MealPlanner::IngredientBook.sample_protein(current_meals).kind)
    end
  end

  def test_sample_protein_should_not_return_a_carb_that_has_reached_the_weekly_limit
    # at the moment we have the weekly frequency hardcoded in the IngredientBook
    # and Eggs have a weekly max frequency = 3

    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Pasta", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Couscous", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
      )
    ]

    1_000.times do
      refute_equal("Eggs", MealPlanner::IngredientBook.sample_protein(current_meals).name)
    end
  end

  def test_sample_carb_should_not_return_a_carb_that_has_reached_the_weekly_limit
    # at the moment we have the weekly frequency hardcoded in the IngredientBook
    # and Barley have a weekly max frequency = 1

    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Barley", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
      )
    ]

    1_000.times do
      refute_equal("Barley", MealPlanner::IngredientBook.sample_carb(current_meals).name)
    end
  end
end
