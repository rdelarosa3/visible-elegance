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


  ######### Admin Panel Link ###########
  def admin_status
    admin = '/admin'
    if current_user.admin?
      "<li class='nav-item'>
        <a href='#{admin}' class='nav-link'>Admin Panel</a>
      </li>".html_safe
    end
  end

  ######### reservations search link ###########
  def reservations_view
    reservations_index = '/reservations'
    if current_user.admin?
      "<li class='nav-item'>
        <a href='#{reservations_index}' class='nav-link'>Search</a>
      </li>".html_safe
    end
  end



end