class CreateSns < ActiveRecord::Migration[6.1]
  def change
    create_table :sns do |t|
      t.string :provider
      t.string :uid
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
