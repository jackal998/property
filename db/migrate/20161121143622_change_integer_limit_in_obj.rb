class ChangeIntegerLimitInObj < ActiveRecord::Migration[5.0]
  def change
    change_column :objs, :value, :integer, limit: 8
  end
end
