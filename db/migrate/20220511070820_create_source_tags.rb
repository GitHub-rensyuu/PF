class CreateSourceTags < ActiveRecord::Migration[6.1]
  def change
    create_table :source_tags do |t|
      t.references :source, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    
    # 同じタグを２回保存するのは出来ないようにする
    add_index :source_tags, [:source_id, :tag_id], unique: true
  end
end
