class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authentication
  @oauth_sign_in = false
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
          @oauth_sign_in = true
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
          @oauth_sign_in = true
        end
      end
    }
  end
  # def facebook
  #   @user = User.find_for_oauth(env["omniauth.auth"], current_user)
  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication
  #     set_flash_message(:notice, :success, kind: facebook.capitalize) if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  

  def google_oauth2
     
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end



   [:twitter, :facebook].each do |provider|
     provides_callback_for provider
   end

  

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
  
  private

  def sign_up_params
    params.require(:user).permit(:name, :dob, :email, :password, :password_confirmation, :age)
  end

  def account_update_params
    params.require(:user).permit(:name, :dob, :email, :password, :password_confirmation, :age)
  end
  
  
end