class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 
   def facebook
    auth = env["omniauth.auth"]

    if user_signed_in?
      User.connect_to_facebook(current_user, auth)
      flash[:notice] = "Facebook Integrate successfully"
      redirect_to statuses_url
    else
    # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to root_path
      end
    end
  end


  def twitter
    auth = env["omniauth.auth"]

    if user_signed_in?
      User.connect_to_twitter(current_user, auth)
      flash[:notice] = "Twitter Integrate successfully"
      redirect_to statuses_url
    else
      @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
        sign_in_and_redirect @user
      else
        session["devise.twitter_uid"] = request.env["omniauth.auth"]
        redirect_to root_path
      end
    end
    
  end

  def linkedin
    auth = env["omniauth.auth"]
    @user = User.connect_to_linkedin(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.linkedin_uid"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
end
