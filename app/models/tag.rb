class Tag < ApplicationRecord
  validates_presence_of :name

  has_many :objs, :through => :obj_tagships
  has_many :obj_tagships, :dependent => :destroy
end
