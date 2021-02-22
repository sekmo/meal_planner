module MealPlanner
  class Meal
    attr_reader :ingredients

    def initialize
      @ingredients = []
    end

    def add_ingredient(ingredient)
      @ingredients << ingredient
    end

    def ==(another_meal)
      ingredients.difference(another_meal.ingredients).none?
    end
  end
end
