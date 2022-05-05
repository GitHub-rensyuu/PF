class CreateUsefuls < ActiveRecord::Migration[6.1]
  def change
    create_table :usefuls do |t|
      t.integer :customer_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
