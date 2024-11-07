class Employees::CalculateSalaryDiscountChannel < ApplicationCable::Channel
  def subscribed
    stream_from "employees:calculate_salary_discount#{params[:channel_id]}"
  end

  def calculate_salary_discount(data)
    base_salary = data['base_salary'].to_f
    salary_discount = INSS::DiscountCalculation.new(base_salary).call

    ActionCable.server.broadcast "employees:calculate_salary_discount#{params[:channel_id]}",
                                 { salary_discount: salary_discount }
  end
end
