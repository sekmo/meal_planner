# MealShuffler
Plan your meals for the whole week

## Description

I would like to generate a meal plan for the whole week, starting from a list of ingredients, showing the right amount of meat, veggies, and carbs for every meal depending if lunch or dinner. Also following certain rules like having pork max once per weeek, or not plan the same ingredient 2 times consecutively.

### Domain
In our weekly meal plan we have 14 **Meals** (1 lunch meal and 1 dinner meal for 7 days).
Each Meal is made up of 3 **Types** of ingredients: Carbs, Proteins, and Minerals. 

An **Ingredient** (e.g. bread, kale, potatoes) has a **Type** and a **Category**. Examples:
- Bread is an Ingredient with Type: "Carbs", Category: "Grains"
- Salmon is an Ingredient with Type: "Proteins", Category: "Fish"
- Potatoes is an Ingredient with Type: "Carbs", Category: "Vegetables"
- Barley is an Ingredient with Type: "Carbs", Category: "Grains"
- Spinach is an Ingredient with Type: "Minerals", Category: "Vegetables"
- Pork is an Ingredient with Type: "Proteins", Category: "Meat"

**Meal** is a combination of 3 ingredients, one per type:
- Green beans, Potatoes, Eggs
- Salmon, Spinach, Rice
- Chicken, Bread, Lettuce

## Features
- [x] Doesn't repeat the same Meal in a plan
- [x] Ingredients maximum weekly frequency (*e.g. pork max 1x /week*)
- [x] Allow the same ingredient maximum once in 3 consecutive meals (allow same meal again only after 2 meals)
