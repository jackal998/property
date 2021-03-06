class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :objs, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :user_collectionships, :dependent => :destroy
  has_many :user_likeships, :dependent => :destroy
  has_many :user_subscribeships, :dependent => :destroy
  has_many :userships, :dependent => :destroy
  serialize :fb_raw_data
  
  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.fb_name = auth.info.name
      user.fb_avatar = auth.info.image
      user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_name = auth.info.name
      user.fb_avatar = auth.info.image
      existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.fb_name = auth.info.name
    user.fb_avatar = auth.info.image
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.fb_raw_data = auth
    user.save!
    return user
  end
  
  def admin?
    self.role == "admin" 
  end
  def access?(target)
    self.admin? || self == target.user
  end
  def see?(target)
    self.admin? || target.ispublic
  end
  def have_new_friend?
    added_me_arr = Usership.where(:friend_id => self.id).pluck(:user_id)
    my_friends_arr = self.userships.pluck(:friend_id)
    (added_me_arr&my_friends_arr) != added_me_arr
  end
end
