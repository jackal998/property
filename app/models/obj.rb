class Obj < ApplicationRecord
	validates_presence_of :name
	validates_uniqueness_of :serial
	validates :datebought, format: { with: /\d{4}-\d{2}-\d{2}/, message: "format should be: yyyy-mm-dd" }
	validates :dateretire, format: { with: /\d{4}-\d{2}-\d{2}/, message: "format should be: yyyy-mm-dd" }
	validates_numericality_of :value, :only_integer => true # 必須是整數
  validates_numericality_of :access_authority, :only_integer => true, :greater_than => 0, :less_than => 5
	validates_presence_of :description

  belongs_to :user

  has_many :public_comments, ->{ where( "ispublic = ?", true)},:dependent => :destroy, :class_name => 'Comment'
  has_many :comments, :dependent => :destroy

  has_many :obj_categoryships, :dependent => :destroy
  has_many :categories, :through => :obj_categoryships

  has_many :user_collectionships, :dependent => :destroy
  has_many :user_likeships, :dependent => :destroy
  has_many :user_subscribeships, :dependent => :destroy

  has_many :tags, :through => :obj_tagships
  has_many :obj_tagships, :dependent => :destroy

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/system/objs/images/:style/鮮乳坊簽名圖.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end