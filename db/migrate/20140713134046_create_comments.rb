class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :game, index: true, null: false
      t.references :user, index: true, null: false
      t.string :text
      t.timestamps
    end
  end
end
