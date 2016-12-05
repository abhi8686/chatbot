class ProfilesController < ApplicationController

  def index
    @users = User.search(params)
  end
  
  def show
    @users = current_user.friends
  	@user = User.find_by_profile_name(params[:id])
  	if @user
  		@statuses = @user.statuses.all.order(id: :desc)
  		render action: :show
  	else 
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end


  def edit
    @user = current_user
    if current_user.a_brief_about_yourself.nil? && current_user.educational_detail.nil? && current_user.work_experience.nil?
      @a_brief_about_yourself = ""
      @educational_detail_collageName = ""
      @educational_detail_courseName = ""
      @educational_detail_locationE = ""
      @work_experience_companyName = ""
      @work_experience_designation = ""
      @work_experience_locationW = ""
    else
      @a_brief_about_yourself = current_user.a_brief_about_yourself.body
      @educational_detail_collageName = current_user.educational_detail.collageName
      @educational_detail_courseName = current_user.educational_detail.courseName
      @educational_detail_locationE = current_user.educational_detail.location
      @work_experience_companyName = current_user.work_experience.companyName
      @work_experience_designation = current_user.work_experience.designation
      @work_experience_locationW = current_user.work_experience.location
      @interest_list = current_user.interest_list.join(", ")
    end
  end

  def profile_params
    #save interests on user.
    current_user.interest_list.add(params[:interest_list], parse: true)
    if current_user.a_brief_about_yourself.nil? && current_user.educational_detail.nil? && current_user.work_experience.nil?
     
      if params[:body] == "" && params[:collageName] == "" && params[:courseName] == "" && params[:locationE] == "" && params[:companyName] == "" && params[:designation] == "" && params[:locationW] == ""
        redirect_to edit_profile_url(current_user)
        flash[:alert] = 'Complete empty fields'
      else
        current_user.a_brief_about_yourself = ABriefAboutYourself.new(body: params[:body])
        current_user.educational_detail = EducationalDetail.new(collageName: params[:collageName] , courseName: params[:courseName], location: params[:locationE])
        current_user.work_experience = WorkExperience.new(companyName: params[:companyName], designation: params[:designation], location: params[:locationW])
      
        respond_to do |format|
            if current_user.save
              format.html { redirect_to statuses_url, notice: 'Profile was successfully created.' }
            else
              format.html { redirect_to edit_profile_url(current_user), alert: 'Profile was not created'}
            end
        end
      end
    else
      current_user.a_brief_about_yourself.update_attributes(body: params[:body])
      current_user.educational_detail.update_attributes(collageName: params[:collageName] , courseName: params[:courseName], location: params[:locationE])
      current_user.work_experience.update_attributes(companyName: params[:companyName], designation: params[:designation], location: params[:locationW])

       respond_to do |format|
            if current_user.save
              format.html { redirect_to statuses_url, notice: 'Profile was successfully updated.' }
            else
              format.html { redirect_to edit_profile_url(current_user), alert: 'Profile was not updated'}
            end
        end
    end
  end

  
end
