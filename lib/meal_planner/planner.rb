module MealPlanner
  class Planner
    def self.generate_plan
      ingredient_book = IngredientBook.new(INGREDIENTS, RULE_MAX_WEEKLY_INGREDIENT_FREQUENCY)
      current_meals = []
      14.times do
        current_meals << MealGenerator.generate(current_meals, ingredient_book)
      end
      current_meals
    end
  end
end
