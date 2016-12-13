class CreateObjCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :obj_categoryships do |t|
      t.integer :obj_id
      t.integer :category_id

      t.timestamps
    end
  end
end
