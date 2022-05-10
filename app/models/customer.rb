class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }# 「50文字以内」

  has_many :sources, dependent: :destroy
  has_many:likes,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many:usefuls,dependent: :destroy
  has_many :view_counts, dependent: :destroy# 閲覧数用

  has_many :follower, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customer, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_customer, through: :followed, source: :follower # 自分をフォローしている人
  
  has_many :reporter, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  has_many :reporting_customer, through: :reporter, source: :reported # 自分が通報している人
  has_many :reporter_customer, through: :reported, source: :reporter # 自分を通報している人

 # ユーザーをフォローする
  def follow(customer_id)
    follower.create(followed_id: customer_id)
  end

  # ユーザーのフォローを外す
  def unfollow(customer_id)
    follower.find_by(followed_id: customer_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(customer)
    following_customer.include?(customer)
  end
  
  # ユーザーを通報する
  def report(customer_id)
    reporter.create(reported_id: customer_id)
  end

  # ユーザーの通報を解除
  def unreport(customer_id)
    reporter.find_by(reported_id: customer_id).destroy
  end

  # 通報していればtrueを返す
  def reporting?(customer)
    reporting_customer.include?(customer)
  end

  # 退会済ユーザーをブロック
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # ゲストログイン設定
  def self.guest
    find_or_create_by!(nickname: 'guestcustomer' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "guestcustomer"
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
