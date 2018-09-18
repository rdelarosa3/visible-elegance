module UsersHelper

  # This will return the current user, if exist
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # a convenient method to set the session to given user's id with the `:user_id` key
  def sign_in(user)
    session[:user_id] = user.id
  end

  # clears the session by setting the value of `:user_id` key to `nil`
  def sign_out
    session[:user_id] = nil
  end

   def authorize
      redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
   end


end