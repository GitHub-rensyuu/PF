class Source < ApplicationRecord
  belongs_to :customer
  has_many:likes,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many :view_counts, dependent: :destroy# 閲覧数用
  
  validates :source,presence:true
  validates :purpose,presence:true,length:{maximum:200}
  validates :performance_review,presence:true
  validates :rate,presence:true
  # validates :recommended_rank,presence:true
  enum recommended_rank: { beginner: 0, intermediate: 1,advanced:2}

  def liked_by?(customer)
    likes.where(customer_id: customer.id).exists?
  end

  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }
  def self.past_week_count
    (0..6).map { |n| created_days_ago(n).count }.reverse
  end
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
end
