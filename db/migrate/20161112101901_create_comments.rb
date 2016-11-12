class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :emotion_tag
      t.string :paragraph
      t.integer :obj_id
      t.integer :user_id

      t.timestamps
    end
  end
end
