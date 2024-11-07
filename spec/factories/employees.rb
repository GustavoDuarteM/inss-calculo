FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    id_document { Faker::IDNumber.valid }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    discount_status { %i[pending applied].sample }
  end
end
