class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null:false
      t.string :slug, null: false
      t.text :note
      t.float :current_value, null: false
      t.timestamp :inactivated_at
      t.references :user, index: true, null: false
      t.timestamps
    end
    add_foreign_key :accounts, :users
  end
end
