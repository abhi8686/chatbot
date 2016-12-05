class Api::V1::InterestsController < ApplicationController

  def index
    @user = User.includes(:a_brief_about_yourself, :educational_detail, :work_experience).
                 find_by_profile_name(params[:profile_name])
    if @user
      @interests = @user.taggings.where(context: "interests").includes(:tag)
    else
      render json: { status: "failure", message: "The profile you are looking for doesn't exist" }, status: 200
    end
  end
end