# It returns unique meals with a carb and a protein, different from the ones
# being passed as input
module MealPlanner
  class MealSampler
    def self.generate(current_meals, ingredient_sampler)
      loop do
        meal = Meal.new(
          carb: ingredient_sampler.sample(:carb, current_meals),
          protein: ingredient_sampler.sample(:protein, current_meals),
          veggie: ingredient_sampler.sample(:veggie, current_meals)
        )
        return meal if !current_meals.include?(meal)
      end
    end
  end
end
