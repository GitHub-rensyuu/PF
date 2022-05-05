class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.integer :customer_id
      t.integer :genres_id
      t.text :source
      t.string :purpose
      t.text :performance_review
      t.text :note
      t.float :reveiw
      t.float :recommended_rank
      t.boolean :is_vaild
      t.boolean :is_public

      t.timestamps
    end
  end
end
