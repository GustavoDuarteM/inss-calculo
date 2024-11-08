# frozen_string_literal: true

module Employees
  class UpdateDiscountSalary
    attr_reader :employee, :discount_salary

    def initialize(employee)
      @employee = employee.reload
      @discount_calculator_provider = INSS::DiscountCalculation.new(employee.salary)
    end

    def call
      return if @employee.applied?
      
      @employee.update!(inss_discount: @discount_calculator_provider.call, discount_status: :applied)
    end
  end
end
