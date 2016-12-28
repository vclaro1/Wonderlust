class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters
	def edit
		@user = current_user
		@user = User.find(current_user.id)
	end


    def update
	    # For Rails 4
	    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
	    # For Rails 3
	    # account_update_params = params[:user]

	    # required for settings form to submit when password is left blank
	    if account_update_params[:password].blank?
	      account_update_params.delete("password")
	      account_update_params.delete("password_confirmation")
	    end

	    @user = User.find(current_user.id)
	    if @user.update_attributes(account_update_params)
	      set_flash_message :notice, :updated
	      # Sign in the user bypassing validation in case their password changed
	      sign_in @user, :bypass => true
	      redirect_to after_update_path_for(@user)
	    else
	      render "edit"
	    end
	end

	private
	def update_resource(resource, params)
	    if current_user.provider == "facebook"
	      params.delete("current_password")
	      resource.update_without_password(params)
	    elsif current_user.provider == "google_oauth2"
	      params.delete("current_password")
	      resource.update_without_password(params)
	    else
	      resource.update_with_password(params)
	    end
	end
	
	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up).push(:name, :age, :dob, :image)
    	devise_parameter_sanitizer.for(:account_update).push(:name, :age, :dob, :image)
    end
end