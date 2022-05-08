# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create!(
   email: "a@a",
   password: "123456"
)

5.times do |n|
   Customer.create!(
      email: "#{n + 1}@#{n + 1}",
      nickname: "名#{n + 1}",
      birthday:"2018-12-05".to_date,
      # birthday: "2000010#{n + 1}",
      introduction: "#{n + 1}です。よろしくお願いします。",
      telephone_number: "0801000000#{n + 1}",
      sex: 1,
      password: "123456",
    )
end

5.times do |n|
   Source.create!(
      customer_id: n + 1,
      source: "https://#{n + 1}",
      purpose: "#{n + 1}確認のため",
      performance_review: "#{n + 1}が確認できました。",
      note:"#{n + 1}が間違ってました。",
      rate:"#{n + 1}",
      recommended_rank:"#{n + 1}"
    )
end
