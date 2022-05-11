class SourceTag < ApplicationRecord
  belongs_to :source
  belongs_to :tag
  validates :source_id, presence: true
  validates :tag_id, presence: true
end
