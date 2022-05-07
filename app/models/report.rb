class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Customer"
  belongs_to :reported, class_name: "Customer"
end