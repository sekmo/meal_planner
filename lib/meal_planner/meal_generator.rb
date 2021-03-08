module MealPlanner
  class MealGenerator
    def self.generate(current_meals)
      loop do
        meal = Meal.new(
          carb: IngredientBook.sample_carb(current_meals),
          protein: IngredientBook.sample_protein(current_meals)
        )
        return meal if !current_meals.include?(meal)
      end
    end
  end
end
