class AddImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :encoded_image, :text
    add_column :users, :image_type, :string
  end
end
