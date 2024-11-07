# frozen_string_literal: true

module INSS
  class DiscountTableByBaseSalary
    attr_reader :table

    def initialize(base_salary)
      @base_salary = base_salary
      @discount_table = Inss::DiscountTable
    end

    def call
      @discount_table.where('min_range <= ?', @base_salary).order(min_range: :desc)
    end
  end
end
