FactoryBot.define do
  factory :inss_discount_table, class: 'Inss::DiscountTable' do
    min_range { 0 }
    max_range { 1000 }
    discount_percentage { 0.1 }
  end
end
