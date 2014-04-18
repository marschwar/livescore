class ChangeTeamImageType < ActiveRecord::Migration
  def change
    change_column :teams, :encoded_image, :text
  end
end
