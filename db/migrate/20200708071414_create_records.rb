class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.integer :user_id, null: false
      t.integer :account_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end

    add_index :records, :user_id
    add_index :records, :account_id
    add_index :records, :category_id
  end
end
