class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :objs, :dependent => :destroy

  has_many :comments, :dependent => :destroy

  has_many :user_collectionships, :dependent => :destroy

  def admin?
    self.role == "admin" 
  end
end
