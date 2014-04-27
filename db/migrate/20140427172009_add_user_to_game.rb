class AddUserToGame < ActiveRecord::Migration
  def change
    add_column :games, :user_id, :integer, null: false
  end
end
