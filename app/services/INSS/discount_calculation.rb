# frozen_string_literal: true

module INSS
  class DiscountCalculation
    def initialize(base_salary)
      @base_salary = base_salary
      @discount_table_provider = DiscountTableByBaseSalary.new(base_salary).call
    end

    def call
      discount_to_apply = 0.0
      @discount_table_provider.each do |discount_table_item|
        discount = calculate_discount(discount_table_item)
        discount_to_apply += discount if discount.positive?
        break if discount.zero?
      end

      discount_to_apply.floor(2)
    end

    private

    def calculate_discount(discount_table_item)
      min_range = discount_table_item.min_range
      max_range = discount_table_item.max_range
      discount_percentage = discount_table_item.discount_percentage

      if @base_salary > max_range
        calculate_discount_on_salary_range(min_range, max_range, discount_percentage)
      elsif @base_salary <= max_range
        calculate_discount_on_last_range(min_range, discount_percentage)
      else
        0
      end
    end

    def calculate_discount_on_salary_range(min_range, max_range, discount_percentage)
      ((max_range - min_range) * discount_percentage).floor(2)
    end

    def calculate_discount_on_last_range(min_range, discount_percentage)
      ((@base_salary - min_range) * discount_percentage).floor(2)
    end
  end
end
