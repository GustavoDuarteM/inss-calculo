# frozen_string_literal: true

module Employees
  class EmployeesByCategoryChannel < ApplicationCable::Channel
    def subscribed
      stream_from "employees:employees_by_category#{params[:channel_id]}"
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def fetch_employees_by_category
      ActionCable.server.broadcast(
        "employees:employees_by_category#{params[:channel_id]}",
        {
          classificated_salaries: classificated_salaries,
          out_of_range_classificated_salaries: out_of_range_classificated_salaries
        }
      )
    end

    def classificated_salaries
      INSS::ClassificatedSalariesByDiscount.new.inner_range
    end

    def out_of_range_classificated_salaries
      INSS::ClassificatedSalariesByDiscount.new.out_of_range.to_a.first
    end
  end
end
