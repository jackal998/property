class Comment < ApplicationRecord
  validates_presence_of :paragraph

  belongs_to :obj , :counter_cache => true
  belongs_to :user
  
end
