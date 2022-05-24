class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.integer :customer_id
      t.integer :genre_id, default: 1
      t.text :source
      t.string :purpose
      t.text :performance_review
      t.text :note
      t.float :rate
      t.float :total_rate
      t.integer :recommended_rank
      t.integer :total_recommended_rank
      t.boolean :is_vaild, default: true
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
