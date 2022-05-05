# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'a@a',
   password: '123456'
)

# 5.times do |n|
#   Customer.create!(
#       email: "#{n + 1}@#{n + 1}",
#       nickname: "名#{n + 1}",
#       first_name_kana: "メイ",
#       last_name_kana: "セイ",
#       password: "123456",
#       telephone_number: "0801234567#{n + 1}"
#     )
# end