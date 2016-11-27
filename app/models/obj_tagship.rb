class ObjTagship < ApplicationRecord
  belongs_to :tag
  belongs_to :obj
end
