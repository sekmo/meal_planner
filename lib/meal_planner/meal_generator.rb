module MealPlanner
  class MealGenerator
    def self.generate(current_meals)
      Meal.new(
        carb: IngredientBook.sample_carb(current_meals),
        protein: IngredientBook.sample_protein(current_meals)
      )
    end
  end
end
