class Comment < ApplicationRecord
  validates :comment,presence:true
  # validates :recommended_rank,presence:true
  # validates :review,presence:true
  belongs_to :customer
  belongs_to :source
end
