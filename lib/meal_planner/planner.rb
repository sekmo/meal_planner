module MealPlanner
  class Planner
    MENU_CHARS_LENGTH = 55
    DAYS_NAMES = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    attr_reader :ingredient_book, :max_weekly_frequency_ingredient
    attr_accessor :meals
    
    def initialize(ingredient_book, max_weekly_frequency_ingredient)
      @ingredient_book = ingredient_book
      @max_weekly_frequency_ingredient = max_weekly_frequency_ingredient
      @meals = []
    end

    def generate_plan
      ingredient_sampler = IngredientSampler.new(ingredient_book, max_weekly_frequency_ingredient)
      14.times do
        meals << MealSampler.generate(meals, ingredient_sampler)
      end
    end

    def print
      puts
      puts "WEEKLY PLAN".center(MENU_CHARS_LENGTH)
      puts "=" * MENU_CHARS_LENGTH
      meals.each_slice(2).with_index do |meals_for_the_day, index|
        puts "#{DAYS_NAMES[index]} lunch: #{meals_for_the_day[0].to_menu_item(:lunch)}"
        puts "#{DAYS_NAMES[index]} dinner: #{meals_for_the_day[1].to_menu_item(:dinner)}"
        # puts "- dinner: #{meals_for_the_day[1].to_menu_item(:dinner)}"
        puts
      end
      puts "=" * MENU_CHARS_LENGTH
    end
  end
end
