# Responsible for yielding the possible ingredients for a new meal, given that we pass all the
# available ingredients, some rules, and the meals we currently have in our weekly plan.
module MealPlanner
  class IngredientSampler
    attr_reader :ingredients, :max_weekly_ingredient_frequency
    def initialize(ingredients, max_weekly_ingredient_frequency)
      @ingredients = ingredients
      @max_weekly_ingredient_frequency = max_weekly_ingredient_frequency
    end

    def carbs
      @carbs ||= ingredients
        .filter { |ingredient| ingredient[:kind] == "carb" }
        .map do |ingredient|
          Ingredient.new(
            name: ingredient[:name],
            kind: ingredient[:kind],
            quantity_for_lunch: ingredient[:quantity_for_lunch],
            quantity_for_dinner: ingredient[:quantity_for_dinner]
          )
        end
    end

    def proteins
      @proteins ||= ingredients
        .filter { |ingredient| ingredient[:kind] == "protein" }
        .map do |ingredient|
          Ingredient.new(
            name: ingredient[:name],
            kind: ingredient[:kind],
            quantity_for_lunch: ingredient[:quantity_for_lunch],
            quantity_for_dinner: ingredient[:quantity_for_dinner]
          )
        end
    end

    def sample(ingredient_kind, current_meals)
      if ingredient_kind == :carb
        (carbs_that_respect_the_weekly_frequency_rule(current_meals) &
          carbs_that_respect_the_last_2_meals_rule(current_meals)).sample
      else
        (proteins_that_respect_the_weekly_frequency_rule(current_meals) &
          proteins_that_respect_the_last_2_meals_rule(current_meals)).sample
      end
    end

    private

    def carbs_in_our_current_meals(current_meals)
      current_meals.map(&:carb)
    end

    def proteins_in_our_current_meals(current_meals)
      current_meals.map(&:protein)
    end

    def carbs_that_respect_the_weekly_frequency_rule(current_meals)
      carbs.select do |carb|
        max_frequency_for_carb = max_weekly_ingredient_frequency.find { |rule| rule[:ingredient] == carb.name}&.fetch(:times)
        !max_frequency_for_carb || carbs_in_our_current_meals(current_meals).count(carb) < max_frequency_for_carb
      end
    end

    def proteins_that_respect_the_weekly_frequency_rule(current_meals)
      proteins.select do |protein|
        max_frequency_for_protein = max_weekly_ingredient_frequency.find { |rule| rule[:ingredient] == protein.name}&.fetch(:times)
        !max_frequency_for_protein || proteins_in_our_current_meals(current_meals).count(protein) < max_frequency_for_protein
      end
    end

    def carbs_in_our_last_2_meals(current_meals)
      current_meals.last(2).map(&:carb)
    end

    def proteins_in_our_last_2_meals(current_meals)
      current_meals.last(2).map(&:protein)
    end

    def carbs_that_respect_the_last_2_meals_rule(current_meals)
      carbs - carbs_in_our_last_2_meals(current_meals)
    end

    def proteins_that_respect_the_last_2_meals_rule(current_meals)
      proteins - proteins_in_our_last_2_meals(current_meals)
    end
  end
end
