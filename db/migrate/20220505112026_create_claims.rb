class CreateClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :claims do |t|
      t.integer :claimer_id
      t.integer :claimed_id
      t.text :text

      t.timestamps
    end
  end
end
