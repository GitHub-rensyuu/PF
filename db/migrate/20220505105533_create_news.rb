class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :text
      t.boolean :is_confirmed, default: false
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
