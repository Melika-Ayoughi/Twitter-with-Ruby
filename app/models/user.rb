class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets

  has_many :followerships, :class_name => "Followship", :foreign_key => "following_id"
  has_many :followers, :through => :followerships, :source => :user
  has_many :followingships, :class_name => "Followship", :foreign_key => "follower_id"
  has_many :followings, :through => :followingships, :source => :user

  has_many :blockerships, :class_name => "Blockship", :foreign_key => "blocked_id"
  has_many :blockers, :through => :blockerships, :source => :user
  has_many :blockedships, :class_name => "Blockship", :foreign_key => "blocker_id"
  has_many :blockeds, :through => :blockedships, :source => :user

end
