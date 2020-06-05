require_relative '../models/meal'
require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    display_meals
  end

  def add
    # Ask the user for name and price
    name = @meals_view.ask_user("name")
    price = @meals_view.ask_user("price").to_i
    # Create new meal
    meal = Meal.new(name: name, price: price)
    @meal_repository.add(meal)
  end

  private

  def display_meals
    meals = @meal_repository.all
    @meals_view.display(meals)
  end
end
