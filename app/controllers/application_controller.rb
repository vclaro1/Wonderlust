class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  before_filter :configure_permitted_parameters, if: :devise_controller?


  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end

  # helper_method :current_user
  # hide_action :current_user
  include PublicActivity::StoreController



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :password_confirmation]
    devise_parameter_sanitizer.for(:account_update) << [:name, :email, :password, :current_password, :sex, :dob, :image]
    devise_parameter_sanitizer.for(:sign_in) << [:email, :remember_me]
  end
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end

