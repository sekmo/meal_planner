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

    def to_menu_item(lunch_or_dinner)
      if lunch_or_dinner == :lunch
        "#{carb.name} (#{carb.quantity_for_lunch} g) - #{protein.name} (#{protein.quantity_for_lunch} g)"
      else
        "#{carb.name} (#{carb.quantity_for_dinner} g) - #{protein.name} (#{protein.quantity_for_dinner} g)"
      end
    end
  end
end
