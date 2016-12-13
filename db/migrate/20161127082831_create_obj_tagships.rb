class CreateObjTagships < ActiveRecord::Migration[5.0]
  def change
    create_table :obj_tagships do |t|
      t.integer :tag_id
      t.integer :obj_id
      t.timestamps
    end
  end
end
