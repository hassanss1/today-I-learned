require_relative "../models/meal"

class MealsView
  def ask_user(something)
    puts "What is the #{something.capitalize}?"
    print "> "
    return gets.chomp
  end

  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name}   -   #{meal.price}€"
    end
  end
end
