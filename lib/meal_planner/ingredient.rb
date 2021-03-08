module MealPlanner
  class Ingredient
    attr_reader :name, :kind, :quantity_for_lunch, :quantity_for_dinner
    def initialize(name:, kind:, quantity_for_lunch: nil, quantity_for_dinner: nil)
      @name = name
      @kind = kind
      @quantity_for_lunch = quantity_for_lunch
      @quantity_for_dinner = quantity_for_dinner
    end

    def ==(other_ingredient)
      name == other_ingredient.name
    end
  end
end
