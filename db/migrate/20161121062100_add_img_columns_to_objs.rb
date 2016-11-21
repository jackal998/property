class AddImgColumnsToObjs < ActiveRecord::Migration[5.0]
  def change
    add_attachment :objs, :image
  end
end
