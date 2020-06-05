class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.log_in
      while @current_user
        puts "\n\n\nWelcome #{@current_user.username}!\n\n\n"
        if @current_user.manager?
          router_manager_action
        else
          router_delivery_guy_action
        end
      end
      system "clear"
    end
  end

  private

  def router_manager_action
    display_manager_tasks
    action = gets.chomp.to_i
    manager_route_action(action)
  end

  def router_delivery_guy_action
    display_delivery_guy_tasks
    action = gets.chomp.to_i
    delivery_guy_route_action(action)
  end

  def manager_route_action(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 9 then logout!
    when 0 then stop
    else puts "Try again..."
    end
  end

  def delivery_guy_route_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 9 then logout!
    when 0 then stop
    else puts "Wrong action!"
    end
  end

  def display_manager_tasks
    puts "---------MANAGER---------"
    puts "----------MENU-----------"
    puts "-------------------------"
    puts "1 - Add new meal"
    puts "2 - Display all meals"
    puts "3 - Add new customer"
    puts "4 - Display all customers"
    puts "5 - Add a new order"
    puts "6 - List undelivered orders"
    common_menu
  end

  def display_delivery_guy_tasks
    puts "------DELIVERY_GUY-------"
    puts "----------MENU-----------"
    puts "-------------------------"
    puts "1 - Mark order as delivered"
    puts "2 - List undelivered orders"
    common_menu
  end

  def common_menu
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end

  def logout!
    @current_user = nil
  end

  def stop
    logout!
    @running = false
  end
end
