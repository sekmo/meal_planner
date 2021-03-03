module MealPlanner
  class Meal
    attr_accessor :carb, :protein

    def initialize(carb: nil, protein: nil)
      @carb = carb
      @protein = protein
    end

    def ==(another_meal)
      carb == another_meal.carb && protein == another_meal.protein
    end
  end
end
