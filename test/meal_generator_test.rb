require "minitest/autorun"
require_relative "test_helper"

class MealPlanner::MealGeneratorTest < MiniTest::Test
  def test_it_should_generate_a_meal_with_a_carb_and_a_protein
    current_meals = []
    ingredient_book = MealPlanner::IngredientBook.new(
      MealPlanner::INGREDIENTS,
      MealPlanner::RULE_MAX_WEEKLY_INGREDIENT_FREQUENCY
    )
    returned_meal = MealPlanner::MealGenerator.generate(current_meals, ingredient_book)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.protein)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.carb)
  end

  def test_it_should_generate_a_meal_different_from_the_ones_passed
    ingredient_book = MealPlanner::IngredientBook.new(
      MealPlanner::INGREDIENTS,
      MealPlanner::RULE_MAX_WEEKLY_INGREDIENT_FREQUENCY
    )
    salmon_with_eggs = MealPlanner::Meal.new(
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
    )
    current_meals = [salmon_with_eggs]

    1_000.times do
      refute_equal(
        salmon_with_eggs,
        MealPlanner::MealGenerator.generate(current_meals, ingredient_book)
      )
    end
  end
end
