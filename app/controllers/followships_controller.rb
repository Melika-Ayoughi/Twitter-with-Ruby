class FollowshipsController < ApplicationController
  before_action :set_followship, only: [:show, :destroy]

  # GET /followships
  # GET /followships.json
  def index
    # arr.each_index.select{|i| arr[i] == 'x'}
    @followships = Followship.select{|followship| followship.follower_id == current_user.id}
  end

  # GET /followships/1
  # GET /followships/1.json
  def show
  end

  # GET /followships/new
  def new
    @friendship_opportunities, friends, blockers, blockeds = [], [], [], []
    for followship in current_user.followingships
      friends.append(followship.following)
    end
    for blockship in current_user.blockerships
      blockers.append(blockship.blocker)
    end
    for blockship in current_user.blockedships
      blockeds.append(blockship.blocked)
    end
    for user in User.all
      if not(friends.include?(user) or blockeds.include?(user) or blockers.include?(user) or user == current_user)
        @friendship_opportunities.append(user)
      end
    end
    @followship = Followship.new
  end

  # POST /followships
  # POST /followships.json
  def create
    @followship = Followship.create(:follower_id => current_user.id, :following_id => followship_params[:following_id])

    respond_to do |format|
      if @followship.save
        format.html { redirect_to @followship, notice: 'Followship was successfully created.' }
        format.json { render :show, status: :created, location: @followship }
      else
        format.html { render :new }
        format.json { render json: @followship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followships/1
  # DELETE /followships/1.json
  def destroy
    @followship.destroy
    respond_to do |format|
      format.html { redirect_to followships_url, notice: 'Followship was successfully unfollowed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_followship
      @followship = Followship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def followship_params
      params.require(:followship).permit(:follower_id, :following_id)
    end
end
