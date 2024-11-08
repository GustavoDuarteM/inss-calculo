# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


[
  { min_range: 0.0, max_range: 1045.0, discount_percentage: 0.075 },
  { min_range: 1045.01, max_range: 2089.6, discount_percentage: 0.09 },
  { min_range: 2089.61, max_range: 3134.4, discount_percentage: 0.12 },
  { min_range: 3134.41, max_range: 6101.06, discount_percentage: 0.14 }
].each do |discount_table_item|
  # Inss::DiscountTable.create(discount_table_item)
  Inss::DiscountTable.find_or_create_by(discount_table_item)
end

10.times do
  new_employee = FactoryBot.build(:employee)
  inss_discount = INSS::DiscountCalculation.new(new_employee.salary).call
  new_employee.assign_attributes(inss_discount: inss_discount, discount_status: :applied)
  new_employee.save!
end
