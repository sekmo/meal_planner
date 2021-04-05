require "minitest/autorun"
require_relative "test_helper"

class MealPlanner::IngredientBookTest < MiniTest::Test
  def test_that_it_creates_a_collection_of_ingredients_from_json
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))

    carb = ingredients_book.carbs.first
    assert_equal(MealPlanner::Ingredient, carb.class)
    assert_equal("Bread", carb.name)
    assert_equal("carb", carb.kind)
    assert_equal(30, carb.quantity_for_lunch)
    assert_equal(80, carb.quantity_for_dinner)

    protein = ingredients_book.proteins.first
    assert_equal(MealPlanner::Ingredient, protein.class)
    assert_equal("Chicken", protein.name)
    assert_equal("protein", protein.kind)
    assert_equal(180, protein.quantity_for_lunch)
    assert_equal(100, protein.quantity_for_dinner)

    veggie = ingredients_book.veggies.first
    assert_equal(MealPlanner::Ingredient, veggie.class)
    assert_equal("Lettuce", veggie.name)
    assert_equal("veggie", veggie.kind)
    assert_equal(57, veggie.quantity_for_lunch)
    assert_equal(100, veggie.quantity_for_dinner)
  end
end
