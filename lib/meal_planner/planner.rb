module MealPlanner
  class Planner
    def self.generate_plan
      ingredient_sampler = IngredientSampler.new(INGREDIENTS, RULE_MAX_WEEKLY_INGREDIENT_FREQUENCY)
      current_meals = []
      14.times do
        current_meals << MealSampler.generate(current_meals, ingredient_sampler)
      end
      current_meals
    end
  end
end
