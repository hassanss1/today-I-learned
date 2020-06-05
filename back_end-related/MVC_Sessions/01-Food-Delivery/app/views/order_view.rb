require_relative "../models/order"

class OrderView
  def ask_user(something)
    puts "What is the #{something.capitalize}?"
    print "> "
    return gets.chomp
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.customer.name} - will be delivered by #{order.employee.username}"
    end
  end
end
