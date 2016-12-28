module UsersHelper
  def options_for_seasons
    [['Male', 'male'], ['Female', 'female']]
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - (dob.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def logged_using_omniauth? request 
    res = nil 
    omniauth = request.env["omniauth.auth"] 
    if omniauth 
      res = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid']) 
    end 
    res 
  end

  def is_current_user?(user)
    user == current_user
  end
end
