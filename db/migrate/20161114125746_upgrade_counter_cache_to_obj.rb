class UpgradeCounterCacheToObj < ActiveRecord::Migration[5.0]
  def change
    rename_column :objs, :comment_counts, :comments_count
    change_column :objs, :comments_count, :integer, :default => 0

    Obj.pluck(:id).each do |i|
      Obj.reset_counters(i, :comments)
    end
  end
end
