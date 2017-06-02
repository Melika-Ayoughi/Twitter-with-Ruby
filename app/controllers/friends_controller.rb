class FriendsController < ApplicationController

  def index
    @users = []
    for followship in current_user.followingships
      @users.push(followship.following)
    end
        # Tweet.select { |tweet| tweet.user_id == current_user.id }
  end
end
