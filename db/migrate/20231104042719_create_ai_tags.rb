class CreateAiTags < ActiveRecord::Migration[6.1]
  def change
    create_table :ai_tags do |t|
      t.string :name
      t.integer :item_id

      t.timestamps
    end
  end
end
