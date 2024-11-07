# frozen_string_literal: true

module Employees
  class UpdateDiscountSalaryJob < ApplicationJob
    queue_as :default

    def perform(employee)
      Employees::UpdateDiscountSalary.new(employee).call
    end
  end
end
