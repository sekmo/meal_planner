require "minitest/autorun"
require_relative "test_helper"

class IngredientBookTest < MiniTest::Test
  def test_sample_carb_should_return_a_random_carb
    1_000.times do
      assert_equal("carb", MealPlanner::IngredientBook.sample_carb.kind)
    end
  end

  def test_sample_protein_should_return_a_random_protein
    1_000.times do
      assert_equal("protein", MealPlanner::IngredientBook.sample_protein.kind)
    end
  end
end
