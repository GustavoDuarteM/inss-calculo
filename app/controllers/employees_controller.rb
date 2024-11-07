class EmployeesController < ApplicationController
  def index; end

  def new
    @employee = Employee.new
  end
end
