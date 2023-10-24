class AddCommentToItemComments < ActiveRecord::Migration[6.1]
  def change
    add_column :item_comments, :comment, :string
  end
end
