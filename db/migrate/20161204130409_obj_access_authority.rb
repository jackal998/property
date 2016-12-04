class ObjAccessAuthority < ActiveRecord::Migration[5.0]
  def change
    add_column :objs, :access_authority, :integer, :default => 4
  end
end
