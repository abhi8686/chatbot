class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :conversation_user
  before_action :friendships_req
  before_action :messages
private
	 def configure_permitted_parameters
	   devise_parameter_sanitizer.for(:sign_up) << :first_name
	   devise_parameter_sanitizer.for(:sign_up) << :last_name
	   devise_parameter_sanitizer.for(:sign_up) << :profile_name
       devise_parameter_sanitizer.for(:account_update) << :password << :password_confirmation << :avatar << :profile_name << :first_name << :last_name

	end

	def after_sign_out_path_for(resource)
	 	root_path
	end

	def after_sign_in_path_for(resource_or_scope)
		if current_user.a_brief_about_yourself.nil? && current_user.educational_detail.nil? && current_user.work_experience.nil?
			flash[:notice] =  "Please complete your profile"
			edit_profile_path(current_user)
		else
			statuses_path
		end
 		
	end

	def conversation_user
		if user_signed_in?
		@conversations = Conversation.involving(current_user).order("created_at DESC")
		end

	end

	def friendships_req
		if user_signed_in?
		@user_friendships = current_user.user_friendships.all
		end
	end
	
	def messages
    @messages = Message.all
  end
end
