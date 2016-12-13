class AddFbNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fb_name, :string
    add_column :users, :fb_avatar, :string
  end
end
