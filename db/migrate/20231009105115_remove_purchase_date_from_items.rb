class RemovePurchaseDateFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :Purchase_date, :integer
  end
end
