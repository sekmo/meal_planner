require "byebug"
require_relative "../lib/meal_planner"

def read_fixture(path)
  File.read(File.join(__dir__, "fixtures" ,path))
end
