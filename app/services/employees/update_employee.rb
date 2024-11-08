# frozen_string_literal: true

module Employees
  class UpdateEmployee
    attr_reader :employee_id, :employee, :params

    def initialize(employee_id, params)
      @employee_id = employee_id
      @employee = Employee.find(employee_id)
      @employee_initial = @employee.dup
      @params = params
      @update_discount_salary_provider = Employees::UpdateDiscountSalaryJob
    end

    def call
      employee.assign_attributes(params)
      employee.discount_status = :pending if salary_changed?

      employee.save!

      @update_discount_salary_provider.perform_later(employee) if employee.valid? && salary_changed?

      [employee, employee.valid?]
    end

    private

    def salary_changed?
      @employee_initial.salary != employee.salary
    end
  end
end
