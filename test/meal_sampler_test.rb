require "minitest/autorun"
require_relative "test_helper"

class MealPlanner::MealSamplerTest < MiniTest::Test
  def setup
    ingredients = JSON.parse(File.read("conf/ingredients.json"), symbolize_names: true)
    max_weekly_ingredient_frequency_rule = JSON.parse(File.read("conf/ingredients.json"), symbolize_names: true)

    @ingredient_sampler = MealPlanner::IngredientSampler.new(
      ingredients,
      max_weekly_ingredient_frequency_rule
    )
  end

  def test_it_should_generate_a_meal_with_a_carb_and_a_protein
    current_meals = []
    returned_meal = MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.protein)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.carb)
  end

  def test_it_should_generate_a_meal_different_from_the_ones_passed
    salmon_with_eggs = MealPlanner::Meal.new(
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
    )
    current_meals = [salmon_with_eggs]

    1_000.times do
      refute_equal(
        salmon_with_eggs,
        MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler)
      )
    end
  end
end
