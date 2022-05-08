class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id
      t.integer :source_id
      t.text :comment
      t.float :recommended_rank
      t.float :rate
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end
end
