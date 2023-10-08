class Genre < ApplicationRecord
  validates :name, presence: true
  belongs_to :item, optional: true
end
