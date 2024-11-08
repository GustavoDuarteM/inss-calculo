# frozen_string_literal: true

module Employees
  class CreateEmployee
    attr_reader :params

    def initialize(params)
      @params = params
      @employee_provider = Employee
    end

    def call
      employee = @employee_provider.new(params)
      employee.assign_attributes(inss_discount: 0, discount_status: :pending)
      employee.save!

      Employees::UpdateDiscountSalaryJob.perform_later(employee) if employee.valid?

      [employee, employee.valid?]
    end
  end
end
