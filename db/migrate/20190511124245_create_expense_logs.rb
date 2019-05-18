class CreateExpenseLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_logs do |t|
      t.references :user, index: true, null: false
      t.references :account, index: true, null: false
      t.references :category,index: true, null: false
      t.float :amount, null: false
      t.text :note
      t.integer :mode, null: false
      t.timestamps
    end

    add_foreign_key :expense_logs, :users
    add_foreign_key :expense_logs, :categories
    add_foreign_key :expense_logs, :accounts

  end
end
