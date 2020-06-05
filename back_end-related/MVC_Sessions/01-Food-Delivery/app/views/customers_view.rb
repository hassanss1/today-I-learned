require_relative "../models/customer"

class CustomersView
  def ask_user(something)
    puts "What is the #{something.capitalize}?"
    print "> "
    return gets.chomp
  end

  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name}   -   living in: #{customer.address}"
    end
  end
end
