class SessionsController < ApplicationController

    # Ominauth sign in and create
  def create_from_omniauth
    
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = callback #redirect back to current
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # page for editing user details on first creation
      # @next = edit_user_path(user)
      @notice = "User created. Please confirm or edit details"
    end

    sign_in(user)  
    redirect_to @next, :notice => @notice
  end



  def new
    # No need for anything in here, we are just going to render our
    # new.html.erb AKA the login page
  end

  def create
    # Look up User in db by the email address submitted to the login form and
    # convert to lowercase to match email in db in case they had caps lock on:
    user = User.find_by(email: params[:login][:email].downcase)
    
    # Verify user exists in db and run has_secure_password's .authenticate() 
    # method to see if the password submitted on the login form was correct: 
    if user && user.authenticate(params[:login][:password]) 
      # Save the user.id in that user's session cookie:
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      # if email or password incorrect, re-render login page:
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

    #redirect back to current path when Omniauth
  def callback
    request.env['omniauth.origin'] || '/default'
  end

  def show
    redirect_to root_url
  end

  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end
