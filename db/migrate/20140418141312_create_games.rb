class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer  :home_team_id, null: false
      t.integer  :away_team_id, null: false
      t.string   :location
      t.integer  :home_quarter_1, null: false, default: 0
      t.integer  :home_quarter_2, null: false, default: 0
      t.integer  :home_quarter_3, null: false, default: 0
      t.integer  :home_quarter_4, null: false, default: 0
      t.integer  :away_quarter_1, null: false, default: 0
      t.integer  :away_quarter_2, null: false, default: 0
      t.integer  :away_quarter_3, null: false, default: 0
      t.integer  :away_quarter_4, null: false, default: 0
      t.boolean  :started, null: false, default: false
      t.boolean  :final, null: false, default: false
      t.timestamps
    end
  end
end
