class CreateObjs < ActiveRecord::Migration[5.0]
  def change
  	add_column :objs, :ispublic, :boolean
  end
end
