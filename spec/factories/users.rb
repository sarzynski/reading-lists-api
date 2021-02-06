FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'test@test.pl' }
    password { 'tester' }
  end
end