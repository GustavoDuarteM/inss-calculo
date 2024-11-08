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
      employee.discount_status = :applied
      employee.save!

      [employee, employee.valid?]
    end
  end
end
