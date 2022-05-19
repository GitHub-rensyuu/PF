class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }# 「50文字以内」

  has_many :sources, dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :usefuls,dependent: :destroy
  has_many :view_counts, dependent: :destroy# 閲覧数用

  has_many :followers, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customers, through: :followers, source: :followed # 自分がフォローしている人
  has_many :follower_customers, through: :followeds, source: :follower # 自分をフォローしている人
  
  has_many :reporters, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reporteds, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  has_many :reporting_customers, through: :reporters, source: :reported # 自分が通報している人
  has_many :reporter_customers, through: :reporteds, source: :reporter # 自分を通報している人

  has_many :notices, dependent: :destroy
  has_many :active_notices, class_name: 'Notice', foreign_key: 'send_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'receive_id', dependent: :destroy


 # ユーザーをフォローする
  def follow(customer_id)
    followers.create(followed_id: customer_id)
  end

  # ユーザーのフォローを外す
  def unfollow(customer_id)
    followers.find_by(followed_id: customer_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(customer)
    following_customers.include?(customer)
  end
  
  # ユーザーを通報する
  def report(customer_id)
    reporters.create(reported_id: customer_id)
  end

  # ユーザーの通報を解除
  def unreport(customer_id)
    reporters.find_by(reported_id: customer_id).destroy
  end

  # 通報していればtrueを返す
  def reporting?(customer)
    reporting_customers.include?(customer)
  end

  # 退会済ユーザーをブロック
  # def active_for_authentication?
  #   super && (is_deleted == false)
  # end

  # ゲストログイン設定
  def self.guest
    find_or_create_by!(nickname: 'guestcustomer' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "guestcustomer"
    end
  end
  
  # フォロー通知
  def create_notice_follow!(current_customer)
    temp = Notice.where(["send_id = ? and receive_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notice = current_customer.active_notices.new(
        receive_id: id,
        action: 'follow'
      )
      notice.save if notice.valid?
    end
  end

  # 画像の保存設定
  has_one_attached :profile_image
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  enum sex: { man: 0, woman: 1 }

end
