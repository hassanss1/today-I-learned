require_relative "../views/session_view"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  def log_in
    username = @session_view.ask_user(:username)
    password = @session_view.ask_user(:password)
    employee = @employee_repository.find_by_username(username)
    return employee if employee && employee.password == password

    @session_view.wrong_credentials
    log_in
  end
end
