# frozen_string_literal: true

module Employees
  class EmployeesTableComponent < ViewComponent::Base
    def initialize(params:)
      @params = params
      @page = params[:page] || 1
      super
    end

    def employees
      @employees ||= Employee.page(@page).per(5)
    end

    def to_currency(value)
      number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
    end
  end
end
