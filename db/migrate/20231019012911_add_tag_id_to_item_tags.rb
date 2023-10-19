class AddTagIdToItemTags < ActiveRecord::Migration[6.1]
  def change
    add_column :item_tags, :tag_id, :integer
  end
end
