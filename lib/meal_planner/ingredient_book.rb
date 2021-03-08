module MealPlanner
  class IngredientBook
    MAX_WEEKLY_INGREDIENT_FREQUENCY = [
      {
        ingredient: "Pork",
        times: 1
      },
      {
        ingredient: "Eggs",
        times: 3
      },
      {
        ingredient: "Barley",
        times: 1
      },
      {
        ingredient: "Spelt",
        times: 1
      }
    ]

    INGREDIENTS = [
      {
        id: 1,
        kind: "carb",
        name: "Bread",
        category: "grain",
        quantity_for_lunch: 30,
        quantity_for_dinner: 80
      },
      {
        id: 2,
        kind: "carb",
        name: "Potatoes",
        category: "veggie",
        quantity_for_lunch: 100,
        quantity_for_dinner: 200
      },
      {
        id: 3,
        kind: "carb",
        name: "Rice",
        category: "grain",
        quantity_for_lunch: 30,
        quantity_for_dinner: 80
      },
      {
        id: 4,
        kind: "carb",
        name: "Couscous",
        category: "grain",
        quantity_for_lunch: 30,
        quantity_for_dinner: 80
      },
      {
        id: 5,
        kind: "carb",
        name: "Quinoa",
        category: "grain",
        quantity_for_lunch: 0,
        quantity_for_dinner: 60
      },
      {
        id: 6,
        kind: "carb",
        name: "Barley",
        category: "grain",
        quantity_for_lunch: 0,
        quantity_for_dinner: 80
      },
      {
        id: 7,
        kind: "carb",
        name: "Spelt",
        category: "grain",
        quantity_for_lunch: 0,
        quantity_for_dinner: 80
      },
      {
        id: 8,
        kind: "protein",
        name: "Chicken",
        category: "meat",
        quantity_for_lunch: 180,
        quantity_for_dinner: 100
      },
      {
        id: 9,
        kind: "protein",
        name: "Pork",
        category: "meat",
        quantity_for_lunch: 100,
        quantity_for_dinner: 150
      },
      {
        id: 10,
        kind: "protein",
        name: "Eggs",
        category: "eggs",
        quantity_for_lunch: 120,
        quantity_for_dinner: 68
      },
      {
        id: 11,
        kind: "protein",
        name: "Salmon",
        category: "fish",
        quantity_for_lunch: 140,
        quantity_for_dinner: 80
      },
      {
        id: 12,
        kind: "protein",
        name: "Pangasius",
        category: "fish",
        quantity_for_lunch: 200,
        quantity_for_dinner: 120
      },
      {
        id: 13,
        kind: "protein",
        name: "Cottage cheese",
        category: "dairy",
        quantity_for_lunch: 57,
        quantity_for_dinner: 100
      }
    ]

    def self.carbs
      @@carbs ||= INGREDIENTS
        .filter { |ingredient| ingredient[:kind] == "carb" }
        .map do |ingredient|
          Ingredient.new(
            name: ingredient[:name],
            kind: ingredient[:kind],
            quantity_for_lunch: ingredient[:quantity_for_lunch],
            quantity_for_dinner: ingredient[:quantity_for_dinner]
          )
        end
    end

    def self.proteins
      @@proteins ||= INGREDIENTS
        .filter { |ingredient| ingredient[:kind] == "protein" }
        .map do |ingredient|
          Ingredient.new(
            name: ingredient[:name],
            kind: ingredient[:kind],
            quantity_for_lunch: ingredient[:quantity_for_lunch],
            quantity_for_dinner: ingredient[:quantity_for_dinner]
          )
        end
    end

    def self.sample_carb(current_meals)
      carbs_that_we_can_add_respecting_the_weekly_frequency = carbs.select do |carb|
        max_frequency_for_carb = MAX_WEEKLY_INGREDIENT_FREQUENCY.find { |rule| rule[:ingredient] == carb.name}&.fetch(:times)
        !max_frequency_for_carb || carbs_in_our_current_meals(current_meals).count(carb) < max_frequency_for_carb
      end

      carbs_that_we_can_add_respecting_the_weekly_frequency.sample
    end

    def self.sample_protein(current_meals)
      proteins_that_we_can_add_respecting_the_weekly_frequency = proteins.select do |protein|
        max_frequency_for_protein = MAX_WEEKLY_INGREDIENT_FREQUENCY.find { |rule| rule[:ingredient] == protein.name}&.fetch(:times)
        !max_frequency_for_protein || proteins_in_our_current_meals(current_meals).count(protein) < max_frequency_for_protein
      end

      proteins_that_we_can_add_respecting_the_weekly_frequency.sample
    end

    def self.carbs_in_our_current_meals(current_meals)
      current_meals.map(&:carb)
    end

    def self.proteins_in_our_current_meals(current_meals)
      current_meals.map(&:protein)
    end
  end
end
