require_relative '../views/order_view'
require_relative '../views/session_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @order_view = OrderView.new
    @session_view = SessionView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.add(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @order_view.display(undelivered_orders)
  end

  def mark_as_delivered(current_user)
    list_my_undelivered_orders
    index = @order_view.ask_user(:index).to_i
    my_orders = @order_repository.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repository.mark_as_delivered(order)
  end

  def list_my_orders(current_user)
    list_my_undelivered_orders(current_user)
  end

  private

  def list_my_undelivered_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @order_view.display(orders)
  end

  def select_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @order_view.ask_user(:index).to_i
    @meal_repository.find(index)
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @order_view.ask_user(:index).to_i
    @customer_repository.find(index)
  end

  def select_employee
    employees = @employee_repository.all
    @session_view.display(employees)
    index = @order_view.ask_user(:index).to_i
    @employee_repository.find(index)
  end
end
