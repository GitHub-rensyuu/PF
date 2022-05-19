# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 管理者
Admin.create!(
   email: "a@a",
   password: "123456"
)


# 会員
7.times do |n|
   Customer.create!(
      email: "#{n + 1}@#{n + 1}",
      nickname: "#{n + 1}太郎",
      birthday:"2018-12-05".to_date,
      introduction: "#{n + 1}太郎です。よろしくお願いします。",
      telephone_number: "0801000000#{n + 1}",
      sex: 1,
      password: "123456",
    )
end

# 情報ソース
5.times do |n|
   Source.create!(
      customer_id: n + 1,
      source: "https://#{n + 1}",
      purpose: "#{n + 1}確認のため",
      performance_review: "#{n + 1}が確認できました。",
      note:"#{n + 1}が間違ってました。",
      rate:n + 1,
      recommended_rank: 0,
      is_public: true
    )
end

Source.create!(
      customer_id: 1,
      source: "https://freesworder.net/rails-link-a/",
      purpose: "urlのハイパーリンク化",
      performance_review: "簡単に実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )

Source.create!(
      customer_id: 1,
      source: "https://qiita.com/ishidamakot/items/2e74d980b3a338e4c784",
      purpose: "長い文字列を省略して表示",
      performance_review: "簡単に実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 2,
      source: "https://qiita.com/mocomou_/items/c3cce91c241e08f9a50b",
      purpose: "kaminariにbootstrapを実装する",
      performance_review: "すぐ実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 2,
      source: "https://getbootstrap.jp/docs/5.0/components/dropdowns/",
      purpose: "レイアウトでドロップダウンを実装する",
      performance_review: "簡単に実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 2,
      source: "https://getbootstrap.jp/docs/4.2/components/navs/",
      purpose: "レイアウトでタブの切り替え機能を実装する",
      performance_review: "簡単に実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 2,
      source: "https://getbootstrap.jp/docs/4.2/components/navs/",
      purpose: "レイアウトでタブの切り替え機能を実装する",
      performance_review: "簡単に実装できた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 3,
      source: "https://qiita.com/pyon_kiti_jp/items/a23660d20e76fffa5dd4",
      purpose: "後からmigrateファイルを修正する",
      performance_review: "とても便利な機能だと感じた。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
    
Source.create!(
      customer_id: 4,
      source: "https://www.youtube.com/watch?v=XCjOHj2po5s",
      purpose: "Youtubeの広告をスキップする",
      performance_review: "とても便利な機能だと感じた。Youtube以外の広告もスキップしてくれるのはありがたい。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )
Source.create!(
      customer_id: 4,
      source: "https://www.naporitansushi.com/nenagara-amazon-prime/",
      purpose: "プライムビデオを倍速で視聴する",
      performance_review: "プライムビデオ以外も倍速にでき、とても便利な機能だと感じた。",
      note: "スマホのiOSのバージョンが高いとdeskreen上でプライムビデオを表示されない問題あり。",
      rate:5,
      recommended_rank: 0,
      is_public: true
    )

# タグ
Tag.create!(
  tagname: "rails"
)
Tag.create!(
  tagname: "ハイパーリンク"
)

Tag.create!(
  tagname: "レイアウト"
)

# 情報ソースとタグの関係
SourceTag.create!(
  source_id: 6,
  tag_id: 2
)

SourceTag.create!(
  source_id: 7,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 8,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 9,
  tag_id: 3, 
)

SourceTag.create!(
  source_id: 10,
  tag_id: 3, 
)

SourceTag.create!(
  source_id: 11,
  tag_id: 3, 
)


# ジャンル
genres = ["未分類"]
genres.length.times do |i|
Genre.create!(
    name: genres[i]
  )
end

