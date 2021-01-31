FactoryBot.define do
  factory :book do
    title { Faker::Lorem.words(number: 2) }
    author { Faker::Lorem.words(number: 2) }
    read { false }
    list_id { nil }
    end
end