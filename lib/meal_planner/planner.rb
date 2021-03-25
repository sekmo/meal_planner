module MealPlanner
  class Planner
    def self.generate_plan(ingredients, max_weekly_frequency_ingredient)
      ingredient_sampler = IngredientSampler.new(ingredients, max_weekly_frequency_ingredient)
      current_meals = []
      14.times do
        current_meals << MealSampler.generate(current_meals, ingredient_sampler)
      end
      current_meals
    end
  end
end
