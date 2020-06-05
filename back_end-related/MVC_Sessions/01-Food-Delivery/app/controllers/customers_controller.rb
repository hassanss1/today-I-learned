require_relative '../models/customer'
require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    display_customers
  end

  def add
    # Ask the user for name and address
    name = @customers_view.ask_user("name")
    address = @customers_view.ask_user("address")
    # Create new customer
    customer = Customer.new(name: name, address: address)
    @customer_repository.add(customer)
  end

  private

  def display_customers
    customers = @customer_repository.all
    @customers_view.display(customers)
  end
end
