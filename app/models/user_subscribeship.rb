class UserSubscribeship < ApplicationRecord
  belongs_to :user
  belongs_to :obj
end
