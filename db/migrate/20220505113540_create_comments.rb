class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id
      t.integer :source_id
      t.text :comment
      t.float :recommended_rank
      t.float :review
      t.boolean :is_valid

      t.timestamps
    end
  end
end
