class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :customer_id
      t.integer :source_id

      t.timestamps
    end
  end
end
