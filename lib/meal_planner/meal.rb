module MealPlanner
  class Meal
    attr_accessor :carb, :protein, :veggie, :meal_type

    def initialize(meal_type:, carb: nil, protein: nil, veggie: nil)
      @carb = carb
      @protein = protein
      @veggie = veggie
      @meal_type = meal_type
    end

    def ingredient_names
      [carb, veggie, protein].compact.map(&:name)
    end

    def ==(another_meal)
      carb == another_meal.carb && protein == another_meal.protein &&  veggie == another_meal.veggie
    end

    def to_menu_item
      case meal_type
      when :lunch
        menu_item = "#{carb.name} (#{carb.quantity_for_lunch} g)"
        menu_item << " - #{veggie.name} (#{veggie.quantity_for_lunch} g)"
        menu_item << " - #{protein.name} (#{protein.quantity_for_lunch} g)"
      when :dinner
        menu_item = "#{carb.name} (#{carb.quantity_for_dinner} g)"
        menu_item << " - #{veggie.name} (#{veggie.quantity_for_dinner} g)"
        menu_item << " - #{protein.name} (#{protein.quantity_for_dinner} g)"
      when :proteinfree_dinner
        menu_item = "#{carb.name} (#{carb.quantity_for_proteinfree_dinner} g)"
        menu_item << " - #{veggie.name} (#{veggie.quantity_for_proteinfree_dinner} g)"
      end
    end
  end
end
