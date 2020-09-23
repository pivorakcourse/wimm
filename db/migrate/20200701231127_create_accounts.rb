class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance, default: 0, null: false
      t.string :type, default: :UkrainianHryvnia, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :accounts, :type
  end
end
