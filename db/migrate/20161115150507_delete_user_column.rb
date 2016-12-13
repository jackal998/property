class DeleteUserColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :objs, :user
  end
end
