class Source < ApplicationRecord
  belongs_to :customer
  has_many:likes,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many :view_counts, dependent: :destroy# 閲覧数用
  has_many :source_tags,dependent: :destroy
  has_many :tags,through: :source_tags
  
  
  # NGワードを定義する
  
  NGWORD_REGEX = /(.)\1{4,}/.freeze
  # blacklist = "死ね|殺す|うんこ"
  
  with_options presence: true do
    with_options format: { without: NGWORD_REGEX, alert: 'は5文字以上の繰り返しは禁止です' } do
      validates :purpose, length: { maximum: 200 }
      validates :performance_review, length: { maximum: 200 }
    end
  end
  validates :source,presence:true
  # validates :purpose,presence:true,length:{maximum:200}
  # validates :performance_review,presence:true
  validates :rate,presence:true
  # validates :recommended_rank,presence:true
  enum recommended_rank: { beginner: 0, intermediate: 1,advanced:2}

  def liked_by?(customer)
    likes.where(customer_id: customer.id).exists?
  end
  
  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_source_tag = Tag.find_or_create_by(name: new)
      self.tags << new_source_tag
    end
  end
  
  def self.search(search_word)
    Source.where(['category LIKE ?', "#{search_word}"])
  end
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }
  def self.past_week_count
    (0..6).map { |n| created_days_ago(n).count }.reverse
  end
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
end
