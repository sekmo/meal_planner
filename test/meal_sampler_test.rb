require "minitest/autorun"
require_relative "test_helper"

class MealPlanner::MealSamplerTest < MiniTest::Test
  def setup
    ingredients_book = MealPlanner::IngredientsBook.new(read_fixture("conf/ingredients.json"))
    max_weekly_ingredient_frequency_rule = JSON.parse(read_fixture("conf/max_weekly_ingredient_frequency_rule.json"), symbolize_names: true)
    @meal_blocklist = JSON.parse(read_fixture("conf/meal_blocklist.json"), symbolize_names: true)

    @ingredient_sampler = MealPlanner::IngredientSampler.new(
      ingredients_book,
      max_weekly_ingredient_frequency_rule
    )
  end

  def test_it_should_generate_a_meal_with_a_carb_a_protein_and_a_veggie
    current_meals = []
    returned_meal = MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler, @meal_blocklist, meal_type: :lunch)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.protein)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.carb)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.veggie)
  end

  def test_it_should_generate_a_meal_without_protein_if_meal_type_is_proteinfree_dinner
    current_meals = []
    returned_meal = MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler, @meal_blocklist, meal_type: :proteinfree_dinner)
    assert_nil(returned_meal.protein)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.carb)
    assert_instance_of(MealPlanner::Ingredient, returned_meal.veggie)
  end

  def test_it_should_generate_a_meal_different_from_the_ones_passed
    salmon_with_eggs = MealPlanner::Meal.new(
      meal_type: :lunch,
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      protein: MealPlanner::Ingredient.new(name: "Salmon", kind: "protein"),
    )
    current_meals = [salmon_with_eggs]

    1_000.times do
      refute_equal(
        salmon_with_eggs,
        MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler, @meal_blocklist, meal_type: :lunch)
      )
    end
  end

  def test_blocklisted_should_not_block_a_meal_with_an_extra_ingredient
    # In the blocklist fixture we have carrots and bread, but not carrots, bread, and cottage cheese
    carrots_with_bread = MealPlanner::Meal.new(
      meal_type: :lunch,
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      veggie: MealPlanner::Ingredient.new(name: "Carrots", kind: "veggie"),
    )
    carrots_with_bread_and_cottage_cheese = MealPlanner::Meal.new(
      meal_type: :lunch,
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      veggie: MealPlanner::Ingredient.new(name: "Carrots", kind: "veggie"),
      protein: MealPlanner::Ingredient.new(name: "Cottage cheese", kind: "protein"),
    )

    assert(MealPlanner::MealSampler.blocklisted?(carrots_with_bread, @meal_blocklist))
    refute(MealPlanner::MealSampler.blocklisted?(carrots_with_bread_and_cottage_cheese, @meal_blocklist))
  end

  def test_it_should_not_generate_a_meal_in_the_blocklist_by_ingredient
    carrots_with_bread = MealPlanner::Meal.new(
      meal_type: :lunch,
      carb: MealPlanner::Ingredient.new(name: "Bread", kind: "carb"),
      veggie: MealPlanner::Ingredient.new(name: "Carrots", kind: "veggie"),
    )
    couscous_with_pumpkin = MealPlanner::Meal.new(
      meal_type: :lunch,
      carb: MealPlanner::Ingredient.new(name: "Couscous", kind: "carb"),
      veggie: MealPlanner::Ingredient.new(name: "Pumpkin", kind: "veggie"),
    )
    current_meals = []

    1_000.times do
      generated_meal = MealPlanner::MealSampler.generate(current_meals, @ingredient_sampler, @meal_blocklist, meal_type: :lunch)
      refute_equal(carrots_with_bread, generated_meal)
      refute_equal(couscous_with_pumpkin, generated_meal)
    end
  end
end
