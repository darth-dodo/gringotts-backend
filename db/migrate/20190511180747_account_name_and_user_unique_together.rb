class AccountNameAndUserUniqueTogether < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, [:name, :user_id], unique: true
  end
end
