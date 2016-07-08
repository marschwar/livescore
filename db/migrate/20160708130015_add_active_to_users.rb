class AddActiveToUsers < ActiveRecord::Migration

  def up
    add_column :users, :active, :boolean, null: false, default: true
    User.where('created_at < ?', '2016-07-08').update_all(active: false)
  end

  def down
    remove_column :users, :active
  end
end
