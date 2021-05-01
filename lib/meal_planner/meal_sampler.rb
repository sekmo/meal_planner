# It's responsible for telling if a meal can be added or not to the plan
# It returns a meal that is different frm the ones that we pass as input, and it's not blocklisted
module MealPlanner
  class MealSampler
    def self.generate(current_meals, ingredient_sampler, meal_blocklist, meal_type:)
      loop do
        meal = Meal.new(
          meal_type: meal_type,
          carb: ingredient_sampler.sample(:carb, current_meals),
          veggie: ingredient_sampler.sample(:veggie, current_meals)
        )
        meal.protein = ingredient_sampler.sample(:protein, current_meals) unless meal_type == :proteinfree_dinner
        return meal if !current_meals.include?(meal) && !blocklisted?(meal, meal_blocklist)
      end
    end

    def self.blocklisted?(meal, meal_blocklist)
      meal_blocklist.any? do |combination|
        combination.map{ |rule| rule[:ingredient] }.compact.sort == meal.ingredient_names.sort
      end
    end
  end
end
