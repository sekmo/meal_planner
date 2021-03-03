module MealPlanner
  class MealGenerator
    def self.generate
      Meal.new(carb: IngredientBook.sample_carb, protein: IngredientBook.sample_protein)
    end
  end
end
