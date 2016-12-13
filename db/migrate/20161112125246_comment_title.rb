class CommentTitle < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :title, :string

    add_index :comments, :obj_id
    add_index :comments, :user_id
  end
end
