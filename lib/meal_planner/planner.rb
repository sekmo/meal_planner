module MealPlanner
  class Planner
    attr_reader :ingredients, :max_weekly_frequency_ingredient
    attr_accessor :meals
    def initialize(ingredients, max_weekly_frequency_ingredient)
      @ingredients = ingredients
      @max_weekly_frequency_ingredient = max_weekly_frequency_ingredient
      @meals = []
    end

    def generate_plan
      ingredient_sampler = IngredientSampler.new(ingredients, max_weekly_frequency_ingredient)
      14.times do
        meals << MealSampler.generate(meals, ingredient_sampler)
      end
    end

    def print
      menu_chars_length = 55
      puts
      puts "WEEKLY PLAN".center(menu_chars_length)
      puts "=" * menu_chars_length

      days_names = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      meals.each_slice(2).with_index do |meals_for_the_day, index|
        puts "#{days_names[index]} lunch: #{meals_for_the_day[0].to_menu_item(:lunch)}"
        puts "#{days_names[index]} dinner: #{meals_for_the_day[1].to_menu_item(:dinner)}"
        # puts "- dinner: #{meals_for_the_day[1].to_menu_item(:dinner)}"
        puts
      end
      puts "=" * menu_chars_length
    end
  end
end
