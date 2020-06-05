require_relative '../models/employee'
require_relative 'base_repository'

class EmployeeRepository < BaseRepository
  def all_delivery_guys
    @elements.select { |employee| employee.delivery_guy? }
  end

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end


  private

  def add
    nil
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    Employee.new(row)
  end
end
