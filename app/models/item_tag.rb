class ItemTag < ApplicationRecord
  #belongs_to :tag, dependent: :destroy
  has_many :tags
  # belongs_to :item
  has_many :items, through: :tags
  
  def tag_type
    name
  end
end
