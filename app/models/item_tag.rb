class ItemTag < ApplicationRecord
  has_many :post_item_tags, dependent: :destroy
  has_many :item, through: :item_tags

  validates :name, presence:true, length:{maximum:50}
end
