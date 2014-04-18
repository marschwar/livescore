class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :encoded_image

      t.timestamps
    end
  end
end
