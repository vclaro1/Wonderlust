class ConfirmationsController < Devise::ConfirmationsController
  
  private
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
	  root_path
	else
	  new_user_session_path
	end
  end
end