class AddUniqueTogetherForNameAndUserInCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, [:user_id, :name], unique: true
  end
end
