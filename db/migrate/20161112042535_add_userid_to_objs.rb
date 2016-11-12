class AddUseridToObjs < ActiveRecord::Migration[5.0]
  def change
    add_column :objs, :user_id, :integer
    add_index :objs, :user_id
  end
end
