# frozen_string_literal: true

module Employees
  class CreateEmployee
    attr_reader :params

    def initialize(params)
      @params = params
      @employee_provider = Employee
      @update_discount_salary_provider = Employees::UpdateDiscountSalaryJob
    end

    def call
      employee = @employee_provider.new(params)
      employee.assign_attributes(inss_discount: 0, discount_status: :pending)
      employee.save!

      @update_discount_salary_provider.perform_later(employee) if employee.valid?

      [employee, employee.valid?]
    end
  end
end
