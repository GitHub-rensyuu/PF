class Source < ApplicationRecord
  belongs_to :customer
  has_many:likes,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many :view_counts, dependent: :destroy# 閲覧数用
  has_many :source_tags,dependent: :destroy
  has_many :tags,through: :source_tags,dependent: :destroy
  has_many :notices, dependent: :destroy
  
  
  # NGワードを定義する
  
  NGWORD_REGEX = /(.)\1{4,}/.freeze
  # blacklist = "死ね|殺す|うんこ"
  with_options presence: true, on: :publicize do
    with_options format: { without: NGWORD_REGEX, alert: 'は5文字以上の繰り返しは禁止です' } do
      validates :purpose, length: { maximum: 200 }
      validates :performance_review
    end
  end
  validates :source,presence:true
  validates :purpose,presence:true,length:{maximum:200}, on: :publicize
  validates :performance_review,presence:true,length: { maximum: 200 }, on: :publicize
  validates :rate,presence:true
  validates :recommended_rank,presence:true
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
      new_source_tag = Tag.find_or_create_by(tagname: new)
      self.tags << new_source_tag
    end
  end
  
  
  # いいね通知機能
  def create_notice_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notice.where(["send_id = ? and receive_id = ? and source_id = ? and action = ? ", current_customer.id, customer_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notice = current_customer.active_notices.new(
        source_id: id,
        receive_id: customer_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.send_id == notice.receive_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end
  
  # コメント通知機能
  def create_notice_comment!(current_customer, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(source_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notice_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notice_comment!(current_customer, comment_id, receive_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notice = current_customer.active_notices.new(
      source_id: id,
      comment_id: comment_id,
      receive_id: receive_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notice.send_id == notice.receive_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end
  
  # def create_notice_by(current_customer)
  #   notice = current_customer.active_notices.new(
  #   source_id: id,
  #     # receive_id: customer_id,
  #     send_id: customer_id,
  #     action: 'comment'
  #   )
  #   if notice.send_id == notice.receive_id
  #         notice.checked = true
  #   end
  #   notice.save if notice.valid?
  # end
  
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
