class SessionView
  def ask_user(something)
    puts "What is the #{something.capitalize}?"
    print "> "
    return gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials... Try again!"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}   -   #{employee.role}"
    end
  end
end
