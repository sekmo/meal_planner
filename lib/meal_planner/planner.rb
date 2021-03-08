module MealPlanner
  class Planner
    def self.generate_plan
      current_meals = []
      14.times do
        # TODO we should inject a IngredientBook (initialized with ingredients and rules)
        # to the MealGenerator (and maybe rename it to IngredientSampler?)
        current_meals << MealGenerator.generate(current_meals)
      end
      current_meals
    end
  end
end
