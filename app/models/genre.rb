class Genre < ApplicationRecord
  has_many :sources, dependent: :destroy
end
