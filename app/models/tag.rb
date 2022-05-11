class Tag < ApplicationRecord
    has_many :source_tags,dependent: :destroy, foreign_key: 'tag_id'
    has_many :sources,through: :source_tags
    validates :name, uniqueness: true, presence: true
end
