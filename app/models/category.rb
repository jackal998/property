class Category < ApplicationRecord

  has_many :obj_categoryships, :dependent => :destroy
  has_many :objs, :through => :obj_categoryships
end
