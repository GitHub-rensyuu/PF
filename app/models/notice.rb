class Notice < ApplicationRecord
 default_scope -> { order(created_at: :desc) }
 belongs_to :source, optional: true
 belongs_to :comment, optional: true
 belongs_to :receive, class_name: 'Customer', foreign_key: 'receive_id', optional: true
 belongs_to :sender, class_name: 'Customer', foreign_key: 'send_id', optional: true
end