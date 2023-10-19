class Tag < ApplicationRecord
  # has_many :items
  belongs_to :item
  # has_many :item_tags
  belongs_to :item_tag
end
