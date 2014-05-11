class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.references :game, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
