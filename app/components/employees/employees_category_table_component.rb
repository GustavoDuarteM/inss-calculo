module Employees
  class EmployeesCategoryTableComponent < ViewComponent::Base
    def classificated_salaries
      @classificated_salaries ||= INSS::ClassificatedSalariesByDiscount.new.inner_range
    end

    def out_of_range_classificated_salaries
      @out_of_range_classificated_salaries ||= INSS::ClassificatedSalariesByDiscount.new.out_of_range.to_a.first
    end

    def to_currency(value)
      number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
    end
  end
end
