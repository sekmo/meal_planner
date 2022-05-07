# Responsible for yielding the possible ingredients for a new meal, given that we pass all the
# available ingredients, some rules, and the meals we currently have in our weekly plan.
module MealPlanner
  class IngredientSampler
    attr_reader :ingredients_book, :max_weekly_ingredient_frequency
    def initialize(ingredients_book, max_weekly_ingredient_frequency)
      @max_weekly_ingredient_frequency = max_weekly_ingredient_frequency
      @ingredients_book = ingredients_book
    end

    def sample(ingredient_kind, current_meals)
      (
        ingredients_of_a_specific_kind_that_respect_the_weekly_frequency_rule(ingredient_kind, current_meals) &
        ingredients_of_a_specific_kind_that_respect_the_last_2_meals_rule(ingredient_kind, current_meals)
      ).sample
    end

    private

    def ingredients_of_a_specific_kind_that_respect_the_weekly_frequency_rule(ingredient_kind, current_meals)
      ingredients_book.ingredients_by_kind(ingredient_kind).select do |ingredient|
        max_frequency_for_ingredient = max_weekly_ingredient_frequency.find { |rule| rule[:ingredient] == ingredient.name}&.fetch(:times)
        !max_frequency_for_ingredient ||
          ingredients_in_our_current_meals_by_kind(ingredient_kind, current_meals).count(ingredient) < max_frequency_for_ingredient
      end
    end

    def ingredients_in_our_current_meals_by_kind(ingredient_kind, current_meals)
      current_meals.map(&ingredient_kind).compact
    end

    def ingredients_of_a_specific_kind_that_respect_the_last_2_meals_rule(kind, current_meals)
      ingredients_book.ingredients_by_kind(kind) - ingredients_of_a_specific_kind_in_our_last_2_meals(kind, current_meals)
    end

    def ingredients_of_a_specific_kind_in_our_last_2_meals(kind, current_meals)
      current_meals.last(2).map(&kind).compact
    end
  end
end