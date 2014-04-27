class AddPossessionToGames < ActiveRecord::Migration
  def change
    add_column :games, :possession, :string, limit: 10
  end
end
