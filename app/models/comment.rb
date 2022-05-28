class Comment < ApplicationRecord
  validates :comment,presence:true
  validates :rate,presence:true
  validates :recommended_rank,presence:true
  
  belongs_to :customer
  belongs_to :source
  has_many:usefuls,dependent: :destroy
  has_many :notices, dependent: :destroy
  
  def usefuld_by?(customer)
    usefuls.where(customer_id: customer.id).exists?
  end

  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end
end
