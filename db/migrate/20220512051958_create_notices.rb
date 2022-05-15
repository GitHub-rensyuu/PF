class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :send_id
      t.integer :receive_id
      t.integer :source_id
      t.integer :comment_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    # add_index :notices, :receive_id
    # add_index :notices, :send_id
    # add_index :notices, :source_id
    # add_index :notices, :comment_id
  end
end
