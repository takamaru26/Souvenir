class CreateItemTags < ActiveRecord::Migration[6.1]
  def change
    create_table :item_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :item_tags, :name, unique:true
  end
end
