class AddNameSerialDateDateRValueSn1Sn2DesUserToProperty < ActiveRecord::Migration[5.0]
  def change
    create_table :objs do |o|
      o.timestamps
    end

  	add_column :objs, :name, :string
  	add_column :objs, :serial, :string
  	add_column :objs, :datebought, :date
  	add_column :objs, :dateretire, :date
  	add_column :objs, :value, :integer
  	add_column :objs, :snumber1, :string
  	add_column :objs, :snumber2, :string
  	add_column :objs, :description, :text
  	add_column :objs, :user, :string
  end
end