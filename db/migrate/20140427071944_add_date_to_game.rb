class AddDateToGame < ActiveRecord::Migration
  def change
    add_column :games, :game_day, :date, null: false
    add_column :games, :game_time, :string
  end
end
