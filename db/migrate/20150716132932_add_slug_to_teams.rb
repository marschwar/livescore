class AddSlugToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :slug, :string

    Team.find_each do |team|
      team.save!
    end
  end

  def down
    remove_column :teams, :slug
  end

end
