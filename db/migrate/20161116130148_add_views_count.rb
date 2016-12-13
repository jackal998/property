class AddViewsCount < ActiveRecord::Migration[5.0]
  def change
    add_column :objs, :views_count, :integer, :default => 0
  end
end
