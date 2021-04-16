module MealPlanner
  class Ingredient
    attr_reader :name, :kind, :quantity_for_lunch, :quantity_for_dinner, :quantity_for_proteinfree_dinner
    def initialize(name:, kind:, quantity_for_lunch: nil, quantity_for_dinner: nil, quantity_for_proteinfree_dinner: nil)
      @name = name
      @kind = kind
      @quantity_for_lunch = quantity_for_lunch
      @quantity_for_dinner = quantity_for_dinner
      @quantity_for_proteinfree_dinner = quantity_for_proteinfree_dinner
    end

    def ==(other_ingredient)
      name.downcase == other_ingredient.name.downcase
    end

    def eql?(other_ingredient)
      self == other_ingredient
    end
  end
end
