class User < ActiveRecord::Base
  has_many :tweets
  has_many :followerships, :class_name => "Followship", :foreign_key => "following_id"
  has_many :followers, :through => :followerships, :source => :user
  has_many :followingships, :class_name => "Followship", :foreign_key => "follower_id"
  has_many :followings, :through => :followingships, :source => :user
end