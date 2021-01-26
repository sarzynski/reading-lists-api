FactoryBot.define do
  factory :list do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end