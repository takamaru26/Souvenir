class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :genles
  has_many :tags, dependent: :destroy
  has_many :item_tags, through: :tags
  
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  def save_item_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.item_tags.pluck(:name) unless self.item_tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.item_tags.delete ItemTag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      item_tag = ItemTag.find_or_create_by(name: new_name) do |item_tag|
        item_tag.name = new_name
      end

      self.item_tags << item_tag
    end
  end
end