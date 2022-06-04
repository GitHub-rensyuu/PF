class Sn < ApplicationRecord
  belongs_to :customer, optional: true
end
