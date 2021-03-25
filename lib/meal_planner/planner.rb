module MealPlanner
  class Planner
    attr_reader :ingredients, :max_weekly_frequency_ingredient
    def initialize(ingredients, max_weekly_frequency_ingredient)
      @ingredients = ingredients
      @max_weekly_frequency_ingredient = max_weekly_frequency_ingredient
    end

    def generate_plan
      ingredient_sampler = IngredientSampler.new(ingredients, max_weekly_frequency_ingredient)
      current_meals = []
      14.times do
        current_meals << MealSampler.generate(current_meals, ingredient_sampler)
      end
      current_meals
    end
  end
end
