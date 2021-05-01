require "minitest/autorun"
require_relative "test_helper"

class IngredientSamplerTest < MiniTest::Test
  def setup
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))
    max_weekly_ingredient_frequency_rule = JSON.parse(read_fixture("conf/max_weekly_ingredient_frequency_rule.json"), symbolize_names: true)

    @ingredient_sampler = MealPlanner::IngredientSampler.new(
      ingredients_book,
      max_weekly_ingredient_frequency_rule
    )
  end

  def test_sample_should_return_a_random_carb
    current_meals = []
    1_000.times do
      assert_equal("carb", @ingredient_sampler.sample(:carb, current_meals).kind)
    end
  end

  def test_sample_should_return_a_random_protein
    current_meals = []
    1_000.times do
      assert_equal("protein", @ingredient_sampler.sample(:protein, current_meals).kind)
    end
  end

  def test_sample_should_not_return_a_protein_that_has_reached_the_weekly_limit
    # Eggs have a weekly max frequency = 2 in the fixture

    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Pasta", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Quinoa", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Pork", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Potatoes", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Rice", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Chicken", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Couscous", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Cottage cheese", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Quinoa", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Pork", kind: "protein"),
        meal_type: :lunch
      ),
    ]

    1_000.times do
      refute_equal("Eggs", @ingredient_sampler.sample(:protein, current_meals).name)
    end
  end

  def test_sample_should_not_return_a_protein_that_is_in_the_last_two_meals
    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Pork", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Couscous", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Pasta", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
        meal_type: :lunch
      )
    ]

    1_000.times do
      refute_equal("Eggs", @ingredient_sampler.sample(:protein, current_meals).name)
      refute_equal("Salmon", @ingredient_sampler.sample(:protein, current_meals).name)
    end
  end

  def test_sample_should_not_return_a_carb_that_has_reached_the_weekly_limit
    # Barley have a weekly max frequency = 1 in the fixture

    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Barley", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
        meal_type: :lunch
      )
    ]

    1_000.times do
      refute_equal("Barley", @ingredient_sampler.sample(:carb, current_meals).name)
    end
  end

  def test_sample_should_not_return_an_carb_that_is_in_the_last_two_meals
    current_meals = [
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Eggs", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Pasta", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
        meal_type: :lunch
      ),
      MealPlanner::Meal.new(
        carb: MealPlanner::Ingredient.new(name: "Couscous", kind: "carb"),
        protein: MealPlanner::Ingredient.new(name: "Pork", kind: "protein"),
        meal_type: :lunch
      )
    ]

    1_000.times do
      refute_equal("Pasta", @ingredient_sampler.sample(:carb, current_meals).name)
      refute_equal("Couscous", @ingredient_sampler.sample(:carb, current_meals).name)
    end
  end
end
