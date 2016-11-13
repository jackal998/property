class Category < ApplicationRecord

  has_many :obj_categoryships
  has_many :objs, :through => :obj_categoryships
end
