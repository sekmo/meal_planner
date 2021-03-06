module MealPlanner
  class Planner
    def self.generate_plan
      meals = []
      14.times do
        meal = nil
        loop do
          meal = MealGenerator.generate
          break if !meals.include?(meal)
        end
        meals << meal
      end
      meals
    end
  end
end
