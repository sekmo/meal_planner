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

    def sample_carb(current_meals)
      carbs_that_we_can_add_respecting_the_weekly_frequency = carbs.select do |carb|
        max_frequency_for_carb = max_weekly_ingredient_frequency.find { |rule| rule[:ingredient] == carb.name}&.fetch(:times)
        !max_frequency_for_carb || carbs_in_our_current_meals(current_meals).count(carb) < max_frequency_for_carb
      end

      carbs_that_we_can_add_respecting_the_weekly_frequency.sample
    end

    def sample_protein(current_meals)
      proteins_that_we_can_add_respecting_the_weekly_frequency = proteins.select do |protein|
        max_frequency_for_protein = max_weekly_ingredient_frequency.find { |rule| rule[:ingredient] == protein.name}&.fetch(:times)
        !max_frequency_for_protein || proteins_in_our_current_meals(current_meals).count(protein) < max_frequency_for_protein
      end

      proteins_that_we_can_add_respecting_the_weekly_frequency.sample
    end

    private

    def carbs_in_our_current_meals(current_meals)
      current_meals.map(&:carb)
    end

    def proteins_in_our_current_meals(current_meals)
      current_meals.map(&:protein)
    end
  end
end
