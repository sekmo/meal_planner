module MealPlanner
  class Ingredient
    attr_reader :name, :kind, :quantity_for_lunch, :quantity_for_dinner
    def initialize(name:, kind:, quantity_for_lunch:, quantity_for_dinner:)
      @name = name
      @kind = kind
      @quantity_for_lunch = quantity_for_lunch
      @quantity_for_dinner = quantity_for_dinner
    end
  end
end
