class Tag < ApplicationRecord
    has_many :source_tags,dependent: :destroy, foreign_key: 'tag_id'
    has_many :sources,through: :source_tags,dependent: :destroy
    validates :tagname, uniqueness: true, presence: true
end
