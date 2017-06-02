class BlockshipsController < ApplicationController
  before_action :set_blockship, only: [:show, :destroy]

  # GET /blockships
  # GET /blockships.json
  def index
    @blockships = Blockship.select{|blockship| blockship.blocker_id == current_user.id}
  end

  # GET /blockships/1
  # GET /blockships/1.json
  def show
  end

  # GET /blockships/new
  def new
    @blockship_opportunities, blockeds = [], []
    for blockship in current_user.blockedships
      blockeds.append(blockship.blocked)
    end
    for user in User.all
      if not(blockeds.include?(user) or user == current_user)
        @blockship_opportunities.append(user)
      end
    end
    @blockship = Blockship.new
  end

  # POST /blockships
  # POST /blockships.json
  def create

    for followship in current_user.followerships
      if followship.follower_id.to_s === blockship_params[:blocked_id]
        followship.destroy
      end
    end
    for followship in current_user.followingships
      if followship.following_id.to_s === blockship_params[:blocked_id]
        followship.destroy
      end
    end


    @blockship = Blockship.create(:blocker_id => current_user.id, :blocked_id => blockship_params[:blocked_id])

    respond_to do |format|
      if @blockship.save
        format.html { redirect_to @blockship, notice: 'Blockship was successfully created.' }
        format.json { render :show, status: :created, location: @blockship }
      else
        format.html { render :new }
        format.json { render json: @blockship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blockships/1
  # DELETE /blockships/1.json
  def destroy
    @blockship.destroy
    respond_to do |format|
      format.html { redirect_to blockships_url, notice: 'Blockship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blockship
      @blockship = Blockship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blockship_params
      params.require(:blockship).permit(:blocker_id, :blocked_id)
    end
end
