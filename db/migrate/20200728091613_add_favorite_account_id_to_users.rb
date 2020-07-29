class AddFavoriteAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite_account_id, :integer
    add_index :users, :favorite_account_id
  end
end
