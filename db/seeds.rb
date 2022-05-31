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

# ジャンル
genres = ["未分類","プログラミング"]
genres.length.times do |i|
Genre.create!(
    name: genres[i]
  )
end

# 情報ソース
# 1
Source.create!(
      customer_id: 1,
      source: "https://freesworder.net/rails-link-a/",
      purpose: "urlのハイパーリンク化",
      performance_review: "簡単に実装できました。<a href=""></a>で囲めばハイパーリンク化すると思い、試しても上手くいかなかった時に見つけたのがこの記事です。
      ",
      rate:4,
      total_rate:4,
      recommended_rank: 0,
      total_recommended_rank: 1,
      is_public: true
    )
# 2
Source.create!(
      customer_id: 1,
      source: "https://qiita.com/ishidamakot/items/2e74d980b3a338e4c784",
      purpose: "長い文字列を省略して表示",
      performance_review: "簡単に実装できました。railsにこのようなメソッドがあるとは知らなかった。",
      note: "ハイパーリンク等文字に機能を持たせる場合にこの方法を使うと機能しなくなることがある。機能はrails、表示はcssで書くようにすると上手くいく。",
      rate:3,
      total_rate:2,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: true
    )
# 3
Source.create!(
      customer_id: 2,
      source: "https://qiita.com/mocomou_/items/c3cce91c241e08f9a50b",
      purpose: "kaminariにbootstrapを実装する",
      performance_review: "すぐ実装できました。ページネーションでkaminariを使っている人におすすめです。",
      rate:4,
      total_rate:4.5,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: true
    )
# 4
Source.create!(
      customer_id: 2,
      source: "https://getbootstrap.jp/docs/5.0/components/dropdowns/",
      purpose: "レイアウトでドロップダウンを実装する",
      performance_review: "簡単に実装できました。ドロップダウンを実装すると見栄えが良くなるのでおすすめです。",
      note: "Turbolinksを無効にしないと機能しないことがある。",
      rate:4,
      total_rate:1,
      recommended_rank: 0,
      total_recommended_rank: 1,
      is_public: true
    )
# 5
Source.create!(
      customer_id: 2,
      source: "https://getbootstrap.jp/docs/4.2/components/navs/",
      purpose: "レイアウトでタブの切り替え機能を実装する",
      performance_review: "簡単に実装できた。タブの切り替え機能を実装するとユーザビリティーが良くなるのでおすすめです。",
      rate:5,
      total_rate:2,
      recommended_rank: 1,
      total_recommended_rank: 0,
      is_public: true
    )
# 6
Source.create!(
      customer_id: 3,
      source: "https://qiita.com/pyon_kiti_jp/items/a23660d20e76fffa5dd4",
      purpose: "後からmigrateファイルを修正する",
      performance_review: "とても便利な機能だと感じた。これを知るまでは苦労してmigrateファイルを修正していた。",
      rate:5,
      total_rate:5,
      recommended_rank: 1,
      total_recommended_rank: 0,
      is_public: true
    )
# 7
Source.create!(
      customer_id: 4,
      source: "https://www.youtube.com/watch?v=XCjOHj2po5s",
      purpose: "Youtubeの広告をスキップする",
      performance_review: "とても便利な機能だと感じた。Youtube以外の広告もスキップしてくれるのはありがたい。",
      rate:5,
      total_rate:5,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: true
    )
# 8
Source.create!(
      customer_id: 4,
      source: "https://www.naporitansushi.com/nenagara-amazon-prime/",
      purpose: "プライムビデオを倍速で視聴する",
      performance_review: "プライムビデオ以外の動画も倍速にでき、とても便利な機能だと感じた。",
      note: "スマホのiOSのバージョンによってdeskreen上でプライムビデオを表示されない問題あり。",
      rate:5,
      total_rate:5,
      recommended_rank: 1,
      total_recommended_rank: 1,
      is_public: true
    )
# 9
Source.create!(
    customer_id: 5,
      source: "https://www.youtube.com/watch?v=hrryguxWc4U&t=24s",
      purpose: "Bootstrapについて理解する",
      performance_review: "Bootstrapの基本について解説しており分かりやすかった。",
      rate:4.5,
      total_rate:4.5,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: true
    )
# 10
Source.create!(
    customer_id: 5,
      source: "https://www.youtube.com/watch?v=kcPBAysgPPg&t=396s",
      purpose: "Bootstrapについて理解する",
      performance_review: "Bootstrapの公式ページの読み方について解説しており分かりやすかった。",
      rate:4.5,
      total_rate:4.5,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: true
    )
# 11
Source.create!(
    customer_id: 6,
      source: "https://asalworld.com/rails-keywords-highlight/",
      purpose: "検索結果の一致部分をハイライトさせる",
      performance_review: "今までGoogle検索などで検索した際のハイライトするシステムが分かり、なるほどと思った。",
      rate:4.5,
      total_rate:4.5,
      recommended_rank: 1,
      total_recommended_rank: 1,
      is_public: true
    )
# 12  
Source.create!(
    customer_id: 6,
      source: "https://qiita.com/nekojoker/items/80448944ec9aaae48d0a",
      purpose: "通知機能の作成",
      performance_review: "実装するのにかなり時間がかかった。一部slim形式で書かれており、slimに慣れていない自分は大変だった。",
      rate:3,
      total_rate:3,
      recommended_rank: 2,
      total_recommended_rank: 2,
      is_public: true
    )
# 13  
Source.create!(
    customer_id: 7,
      source: "https://qiita.com/y_h_tomo/items/be10099abf93893fee57",
      purpose: "NGワード登録機能の作成",
      performance_review: "実装するのにかなり時間がかかった。",
      note: "ここで紹介しているgemは8年前ぐらいの古いもので、完全一致しかNGワードとして弾いてくれなかったのでイマイチだった。こちらの方がよさげ。https://qiita.com/NishidaRyu416/items/a2642d6a2cb9400ea4da",
      rate:3,
      total_rate:3,
      recommended_rank: 1,
      total_recommended_rank: 1,
      is_public: true
    )
# 14
Source.create!(
    customer_id: 7,
      source: "https://zenn.dev/creationup2u/articles/ccf11532f09a68",
      purpose: "スプレッドシートで目次を作る",
      performance_review: "少し時間がかかったが実装できた。目次へジャンプできるリンクも作れると良いと思った。",
      rate:3,
      total_rate:3,
      recommended_rank: 1,
      total_recommended_rank: 1,
      is_public: true
  )
# 15
Source.create!(
    customer_id: 7,
      source: "https://qiita.com/nagareboshi/items/66aaadf495911493e854",
      purpose: "ER図からテーブル定義書を自動生成",
      performance_review: "いつかやってみようと思う。",
      rate:3,
      total_rate:3,
      recommended_rank: 0,
      total_recommended_rank: 0,
      is_public: false
  )

# タグ
# 1
Tag.create!(
  tagname: "rails"
)
# 2
Tag.create!(
  tagname: "ハイパーリンク"
)
# 3
Tag.create!(
  tagname: "レイアウト"
)
# 4
Tag.create!(
  tagname: "Bootstrap"
)
# 5
Tag.create!(
  tagname: "Youtube"
)
# 6
Tag.create!(
  tagname: "プライムビデオ"
)
# 7
Tag.create!(
  tagname: "検索"
)
# 情報ソースとタグの関係
SourceTag.create!(
  source_id: 1,
  tag_id: 1
)

SourceTag.create!(
  source_id: 1,
  tag_id: 2
)

SourceTag.create!(
  source_id: 2,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 3,
  tag_id: 4, 
)

SourceTag.create!(
  source_id: 4,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 4,
  tag_id: 3, 
)

SourceTag.create!(
  source_id: 5,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 5,
  tag_id: 3, 
)
SourceTag.create!(
  source_id: 6,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 7,
  tag_id: 5, 
)

SourceTag.create!(
  source_id: 8,
  tag_id: 6, 
)

SourceTag.create!(
  source_id: 9,
  tag_id: 4, 
)

SourceTag.create!(
  source_id: 10,
  tag_id: 4, 
)

SourceTag.create!(
  source_id: 11,
  tag_id: 1, 
)

SourceTag.create!(
  source_id: 11,
  tag_id: 7, 
)

SourceTag.create!(
  source_id: 12,
  tag_id: 1, 
)


# レビュー
Comment.create!(
  source_id: 1,
  customer_id: 2, 
  title:"助かりました",
  comment:"なかなか記事が見つからなかったので、とても助かりました。",
  recommended_rank:1,
  rate:4
)

Comment.create!(
  source_id: 2,
  customer_id: 3, 
  title:"CSSで書いた方が良さげ",
  comment:"レスポンシブ対応もできるため、こちらのやり方よりCSSで書いた方が良さそう。",
  recommended_rank:0,
  rate:2
)
Comment.create!(
  source_id: 3,
  customer_id: 2, 
  title:"秒でできました",
  comment:"本当に簡単でした。",
  recommended_rank:0,
  rate:4.5
)

Comment.create!(
  source_id: 4,
  customer_id: 3, 
  title:"微妙でした",
  comment:"rails6環境です。この機能を使うためにはturbolinksを全て削除するか、js関連をwebpacker読み込みからcdnに変える必要があったので、あまり良くないかもしれません。",
  recommended_rank:1,
  rate:1
)

Comment.create!(
  source_id: 5,
  customer_id: 3, 
  title:"思ったより大変でした",
  comment:"JavaScript behaviorの近くに書いているのを参考にしてできました。探すのに時間がかかりました。",
  recommended_rank:1,
  rate:2
)

Comment.create!(
  source_id: 6,
  customer_id: 5, 
  title:"便利です",
  comment:"後からカラムを追加するときにこの方法を使っています。",
  recommended_rank:0,
  rate:5
)

Comment.create!(
  source_id: 7,
  customer_id: 5, 
  title:"これは便利!",
  comment:"Youtubeの動画を見る際はいつもお世話になっています。",
  recommended_rank:0,
  rate:5
)

Comment.create!(
  source_id: 8,
  customer_id: 2, 
  title:"素晴らしい!",
  comment:"今までこのような機能があることを知らなかった。2倍速で見るようになり、プライムビデオ視聴時間が大幅に削減された。",
  recommended_rank:1,
  rate:5
)

Comment.create!(
  source_id: 9,
  customer_id: 6, 
  title:"Bootstrap初心者におすすめ!",
  comment:"Bootstrap初心者に私でも理解できる内容でした。",
  recommended_rank:0,
  rate:4.5
)

Comment.create!(
  source_id: 10,
  customer_id: 6, 
  title:"公式サイトの読み方が分かる",
  comment:"Bootstrapの公式サイトをどのようにして読むかイメージが掴めない人におすすめです。",
  recommended_rank:0,
  rate:4.5
)