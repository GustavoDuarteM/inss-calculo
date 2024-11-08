# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index; end

  def new
    @employee = Employee.new
  end

  def create
    @employee, success = Employees::CreateEmployee.new(create_employee_params).call

    if success
      redirect_to employees_path
    else
      render :new
    end
  end

  private

  def create_employee_params
    params.require(:employee).permit(:name, :birth_date, :id_document, :salary, :inss_discount)
  end
end
