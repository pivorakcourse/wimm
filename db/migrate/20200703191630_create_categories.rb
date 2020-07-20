class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :icon
      t.string :type, default: :WithdrawCategory, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :categories, :type
  end
end
