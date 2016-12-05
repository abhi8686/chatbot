class ABriefAboutYourselvesController < ApplicationController
  before_action :set_a_brief_about_yourself, only: [:show, :edit, :update, :destroy]

  # GET /a_brief_about_yourselves
  # GET /a_brief_about_yourselves.json
  def index
    @a_brief_about_yourselves = ABriefAboutYourself.all
  end

  # GET /a_brief_about_yourselves/1
  # GET /a_brief_about_yourselves/1.json
  def show
  end

  # GET /a_brief_about_yourselves/new
  def new
    @a_brief_about_yourself = ABriefAboutYourself.new
  end

  # GET /a_brief_about_yourselves/1/edit
  def edit
  end

  # POST /a_brief_about_yourselves
  # POST /a_brief_about_yourselves.json
  def create
    if current_user.a_brief_about_yourself.nil?
      @a_brief_about_yourself = current_user.create_a_brief_about_yourself(a_brief_about_yourself_params)

      respond_to do |format|
        if @a_brief_about_yourself.save
          format.html { redirect_to statuses_url, notice: 'A brief about yourself was successfully created.' }
          format.json { render :show, status: :created, location: @a_brief_about_yourself }
        else
          format.html { redirect_to edit_profile_url(current_user), alert: 'A brief about yourself was not created'}
          format.json { render json: @a_brief_about_yourself.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_profile_url(current_user)
      flash[:alert] = 'Already exists A brief about yourself'
    end
  end

  # PATCH/PUT /a_brief_about_yourselves/1
  # PATCH/PUT /a_brief_about_yourselves/1.json
  def update
    respond_to do |format|
      if @a_brief_about_yourself.update(a_brief_about_yourself_params)
        format.html { redirect_to @a_brief_about_yourself, notice: 'A brief about yourself was successfully updated.' }
        format.json { render :show, status: :ok, location: @a_brief_about_yourself }
      else
        format.html { render :edit }
        format.json { render json: @a_brief_about_yourself.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /a_brief_about_yourselves/1
  # DELETE /a_brief_about_yourselves/1.json
  def destroy
    @a_brief_about_yourself.destroy
    respond_to do |format|
      format.html { redirect_to a_brief_about_yourselves_url, notice: 'A brief about yourself was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_a_brief_about_yourself
      @a_brief_about_yourself = ABriefAboutYourself.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def a_brief_about_yourself_params
      params.require(:a_brief_about_yourself).permit(:body)
    end
end
