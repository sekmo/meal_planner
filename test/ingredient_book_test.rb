require "minitest/autorun"
require_relative "test_helper"

class MealPlanner::IngredientBookTest < MiniTest::Test
  def test_that_it_creates_a_collection_of_ingredients_from_json
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))

    carb = ingredients_book.ingredients_by_kind(:carb).first
    assert_equal(MealPlanner::Ingredient, carb.class)
    assert_equal("Bread", carb.name)
    assert_equal("carb", carb.kind)
    assert_equal(30, carb.quantity_for_lunch)
    assert_equal(30, carb.quantity_for_dinner)

    protein = ingredients_book.ingredients_by_kind(:protein).first
    assert_equal(MealPlanner::Ingredient, protein.class)
    assert_equal("Chicken", protein.name)
    assert_equal("protein", protein.kind)
    assert_equal(180, protein.quantity_for_lunch)
    assert_equal(180, protein.quantity_for_dinner)

    veggie = ingredients_book.ingredients_by_kind(:veggie).first
    assert_equal(MealPlanner::Ingredient, veggie.class)
    assert_equal("Lettuce", veggie.name)
    assert_equal("veggie", veggie.kind)
    assert_equal(300, veggie.quantity_for_lunch)
    assert_equal(300, veggie.quantity_for_dinner)
  end

  def test_ingredients_by_kind_returns_all_the_ingredients_of_a_specific_kind
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))

    assert_equal(
      ["Bread", "Potatoes", "Rice", "Couscous", "Quinoa", "Barley", "Spelt"],
      ingredients_book.ingredients_by_kind(:carb).map(&:name)
    )

    assert_equal(
      ["Lettuce", "Green beans", "Peas", "Spinach", "Chard", "Carrots", "Kale", "Tomatoes", "Zucchini", "Mushrooms", "Pumpkin"],
      ingredients_book.ingredients_by_kind(:veggie).map(&:name)
    )

    assert_equal(
      ["Chicken", "Pork", "Veal", "Eggs", "Salmon", "Tuna", "Seafood", "Sardine", "Mackerel", "Cottage cheese"],
      ingredients_book.ingredients_by_kind(:protein).map(&:name)
    )
  end
end
