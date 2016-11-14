class Obj < ApplicationRecord
	validates_presence_of :name
	validates_uniqueness_of :serial
	validates :datebought, format: { with: /\d{4}-\d{2}-\d{2}/, message: "format should be: yyyy-mm-dd" }
	validates :dateretire, format: { with: /\d{4}-\d{2}-\d{2}/, message: "format should be: yyyy-mm-dd" }
	validates_numericality_of :value, :only_integer => true # 必須是整數
	validates_presence_of :description

  belongs_to :user

  has_many :comments
  has_many :obj_categoryships
  has_many :categories, :through => :obj_categoryships

end