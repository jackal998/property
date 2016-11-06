class Obj < ApplicationRecord
	validates_presence_of :name
	validates_uniqueness_of :serial
	validates_numericality_of :value, :only_integer => true # 必須是整數
	validates_presence_of :description
end


#   	add_column :objs, :name, :string
#   	add_column :objs, :serial, :string
#   	add_column :objs, :datebought, :date
#   	add_column :objs, :dateretire, :date
#   	add_column :objs, :value, :integer
#   	add_column :objs, :snumber1, :string
#   	add_column :objs, :snumber2, :string
#   	add_column :objs, :description, :text
#   	add_column :objs, :user, :string