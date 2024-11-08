# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index; end

  def new
    @employee = Employee.new
  end

  def create
    @employee, success = Employees::CreateEmployee.new(employee_params).call

    if success
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee, success = Employees::UpdateEmployee.new(params[:id], employee_params).call

    if success
      redirect_to employees_path
    else
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :birth_date, :id_document, :salary)
  end
end
