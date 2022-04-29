# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  name:  '管理者',
  email: 'admin@gmail.com',
  password:  '123456',
  password_confirmation: '123456',
  admin: true
)

20.times do
  user = User.create!(
    name: Faker::JapaneseMedia::StudioGhibli.unique.character,
    email: Faker::Internet.unique.email,
    password: '123456',
    password_confirmation: '123456',
  )
  puts "\"#{user.name}\" has created!"
end

User.all.each do |user|
  user.questions.create!(
    title: 'タイトル',
    body: 'テキストテキストテキストテキスト'
  )
end