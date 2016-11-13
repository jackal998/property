class CommentsCounterForObjs < ActiveRecord::Migration[5.0]
  def change
    add_column :objs, :comment_counts, :integer
  end
end
