FactoryBot.define do
  factory :book do
    title { Faker::StarWars.character }
    author { Faker::StarWars.character }
    read { false }
    book_id { nil }
    end
end