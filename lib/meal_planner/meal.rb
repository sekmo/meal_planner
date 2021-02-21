module MealPlanner
  class Meal
    attr_reader :ingredients

    def initialize
      @ingredients = []
    end

    def add_ingredient(ingredient)
      @ingredients << ingredient
    end
  end
end
