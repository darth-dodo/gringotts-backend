class CreateCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :eligible_mode, null: false
      t.timestamp :inactivated_at
      t.references :user, index: true, null: false
    end
    add_foreign_key :categories, :users
  end
end
