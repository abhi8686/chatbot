class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  
  # GET /statuses
  # GET /statuses.json
  def index
    ids = current_user.friends.pluck(:id) << current_user.id
    @statuses_all = Status.where(user_id: ids).order(id: :desc)
    @status = Status.new

    @statuses = current_user.statuses.all

    @users = current_user.friends
    @user = current_user

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create_post_video
    @status = Status.new
  end


  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.new(status_params)

    if current_user.state_facebook? && @status.content?
      current_user.facebook(current_user).put_wall_post(@status.content)
    end

    if current_user.state_twitter? && @status.content?
      current_user.twitter(current_user).update(@status.content)
    end
    
    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_url, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { redirect_to statuses_url }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update

    #LA
    #@status = current_user.statuses.find(status_params)

    #if (status_params) && (status_params).has_key?(:user_id)
    #  (status_params).delete(:user_id) 
    #end

    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to statuses_url, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end


  def upvote
    @status = Status.find(params[:id])
    @status.liked_by current_user
    @path = status_path(@status)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end
  end

  def downvote
    @status.downvote_from current_user
    redirect_to statuses_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:user_id, :content, :image, :video)
    end
end
