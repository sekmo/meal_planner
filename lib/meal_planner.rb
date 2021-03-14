$LOAD_PATH.unshift File.join(__dir__, "meal_planner")
require "ingredient"
require "meal"
require "ingredient_sampler"
require "meal_sampler"
require "planner"

module MealPlanner
  RULE_MAX_WEEKLY_INGREDIENT_FREQUENCY = [
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
end
