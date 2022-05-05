class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :customer_id
      t.string :title
      t.text :text
      t.text :reply

      t.timestamps
    end
  end
end
