module INSS
  class ClassificatedSalariesByDiscount
    def initialize
      @inss_discount_table_provider = Inss::DiscountTable
      @employee_provider = Employee
    end

    def inner_range
      @inss_discount_table_provider.select('inss_discount_tables.min_range, inss_discount_tables.max_range, COUNT(employees.id) as employees_count')
                                  .joins('LEFT JOIN employees ON employees.salary BETWEEN inss_discount_tables.min_range AND inss_discount_tables.max_range')
                                  .group('inss_discount_tables.id')
                                  .order('inss_discount_tables.min_range')
    end

    def out_of_range
      @employee_provider.select('COUNT(employees.id) as employees_count')
                        .where('employees.salary > ?', @inss_discount_table_provider.maximum(:max_range))
    end
  end
end
