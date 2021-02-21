module MealPlanner
  class Ingredient
    attr_reader :name, :quantity_for_lunch, :quantity_for_dinner
    def initialize(name: , quantity_for_lunch:, quantity_for_dinner:)
      @name = name
      @quantity_for_lunch = quantity_for_lunch
      @quantity_for_dinner = quantity_for_dinner
    end
  end
end
