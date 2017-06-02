class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.select { |tweet| tweet.user_id == current_user.id }
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.create(:user_id => current_user.id, :text => tweet_params[:text])

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_friends_tweets
    @user_tweets = []
    tweets = []
    for followship in current_user.followingships
      tweets.concat(followship.following.tweets)
    end
    sorted_tweets = tweets.sort_by &:created_at
    sorted_tweets.each do |tweet|
      @user_tweets.append({:user => User.find(tweet.user_id), :tweet => tweet})
    end
  end

  def show_username_tweets
    # exists = false;
    # for followship in current_user.followingships
    #   if followship.following.email == params[:username]
    #     exists = true;
    #   end
    # end

    @tweets = User.find_by_email(params[:username]+'@gmail.com').tweets
    print params[:username]
    print '================================================'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:user_id, :text)
    end
end
