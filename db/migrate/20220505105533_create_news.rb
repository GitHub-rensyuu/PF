class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :text
      t.boolean :is_confirmed
      t.boolean :is_public

      t.timestamps
    end
  end
end
