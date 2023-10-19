class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :item,              null: false, foreign_key: true
      t.references :item_tag,          null: false, foreign_key: true
      t.timestamps
    end
    # 1記事に同じタグは２回保存出来ない
    add_index :tags, [:item_id,:item_tag_id],unique: true
  end
end
