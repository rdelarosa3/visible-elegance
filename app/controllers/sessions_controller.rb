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
      @next = edit_user_path(user)
      @notice = "User created. Please confirm or edit details"
    end

    sign_in(user)  
    redirect_to @next, :notice => @notice
  end

  def new

  end

  def create
    
    # convert to lowercase to match email in db in case they had caps lock on:
    user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      # Verify user exists in db and run has_secure_password's .authenticate() 
      # method to see if the password submitted on the login form was correct: 
      if user && user.authenticate(params[:session][:password]) 
        # Save the user.id in that user's session cookie:
        sign_in(user)
        if URI(request.referer).path == '/contact'
          format.html {redirect_to new_reservation_path, notice: "Welcome" }
        else 
         format.html {redirect_to root_path, notice: "Welcome!"}
        end
        
      else
        # if email or password incorrect, render partial login form:
        format.js { render :file => "/layouts/application.js"}
        flash.now.alert = "Incorrect email or password, try again."
        
      end
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
    redirect_to root_path, notice: "Logged out!"
  end
end
