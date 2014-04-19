class DropFinalFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :final
    remove_column :games, :started
    add_column :games, :period, :string, null: false, default: :unstarted
  end
end
