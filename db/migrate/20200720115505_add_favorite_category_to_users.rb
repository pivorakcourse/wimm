class AddFavoriteCategoryToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite_category_id, :integer
    add_index :users, :favorite_category_id
  end
end
