50.times do
  list = List.create(name: Faker::Lorem.word, created_by: User.first.id)
  list.books.create(title: Faker::Lorem.word, author: Faker::Lorem.word, read: false)
end