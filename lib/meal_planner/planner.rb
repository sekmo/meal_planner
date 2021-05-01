module MealPlanner
  class Planner
    MENU_CHARS_LENGTH = 55
    DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    PROTEINFREE_DINNER_DAYS = ["Tuesday", "Thursday", "Saturday", "Sunday"]

    attr_reader :ingredient_sampler
    attr_accessor :meals
    
    def initialize(ingredient_book, max_weekly_frequency_ingredient)
      @ingredient_sampler = IngredientSampler.new(ingredient_book, max_weekly_frequency_ingredient)
      @meals = []
    end

    def generate_plan
      DAYS.each do |day|
        meals << generate_lunch
        meals << generate_dinner(proteinfree: PROTEINFREE_DINNER_DAYS.include?(day))
      end
    end

    def generate_lunch
      MealSampler.generate(
        meals,
        ingredient_sampler,
        meal_type: :lunch
      )
    end

    def generate_dinner(proteinfree: false)
      MealSampler.generate(
        meals,
        ingredient_sampler,
        meal_type: (proteinfree ? :proteinfree_dinner : :dinner)
      )
    end

    def print
      puts
      puts "WEEKLY PLAN".center(MENU_CHARS_LENGTH)
      puts "=" * MENU_CHARS_LENGTH
      meals.each_slice(2).with_index do |meals_for_the_day, index|
        puts "#{DAYS[index]} lunch: #{meals_for_the_day[0].to_menu_item}"
        puts "#{DAYS[index]} dinner: #{meals_for_the_day[1].to_menu_item}"
        puts
      end
      puts "=" * MENU_CHARS_LENGTH
    end
  end
end
