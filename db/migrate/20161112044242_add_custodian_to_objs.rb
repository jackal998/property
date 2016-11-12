class AddCustodianToObjs < ActiveRecord::Migration[5.0]
  def change
    add_column :objs, :custodian, :string
  end
end
