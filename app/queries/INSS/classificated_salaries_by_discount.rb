# frozen_string_literal: true

module INSS
  class ClassificatedSalariesByDiscount
    def initialize
      @inss_discount_table_provider = Inss::DiscountTable
      @employee_provider = Employee
    end

    def inner_range
      @inss_discount_table_provider.select(select_clause)
                                   .joins(join_clause)
                                   .group('inss_discount_tables.id')
                                   .order('inss_discount_tables.min_range')
    end

    def out_of_range
      @employee_provider.select('COUNT(employees.id) as employees_count')
                        .where('employees.salary > ?', @inss_discount_table_provider.maximum(:max_range))
    end

    private

    def select_clause
      <<~SQL.squish
        inss_discount_tables.min_range, inss_discount_tables.max_range, COUNT(employees.id) as employees_count
      SQL
    end

    def join_clause
      <<~SQL.squish
        LEFT JOIN employees ON employees.salary BETWEEN inss_discount_tables.min_range AND inss_discount_tables.max_range
      SQL
    end
  end
end
