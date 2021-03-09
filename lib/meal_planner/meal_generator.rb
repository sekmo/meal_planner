# It creates unique meals with a carb and a protein, different from the ones being passed
module MealPlanner
  class MealGenerator
    def self.generate(current_meals, ingredient_sampler)
      loop do
        meal = Meal.new(
          carb: ingredient_sampler.sample_carb(current_meals),
          protein: ingredient_sampler.sample_protein(current_meals)
        )
        return meal if !current_meals.include?(meal)
      end
    end
  end
end
