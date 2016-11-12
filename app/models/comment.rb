class Comment < ApplicationRecord
  validates_presence_of :paragraph

  belongs_to :obj
  belongs_to :user

  
end
