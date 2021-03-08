module MealPlanner
  class Planner
    def self.generate_plan
      current_meals = []
      14.times do
        meal = nil
        loop do
          # TODO we should inject a IngredientBook (initialized with ingredients and rules)
          # to the MealGenerator (and maybe rename it to IngredientSampler?)
          meal = MealGenerator.generate(current_meals)
          break if !current_meals.include?(meal)
        end
        current_meals << meal
      end
      current_meals
    end
  end
end
