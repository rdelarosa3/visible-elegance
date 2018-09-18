Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	# Add a root route if you don't have one...
	####
	root to: 'users#new'
  	
  	#### CREATE USER ################
  	# sign up page with form:
	get 'users/new' => 'users#new', as: :new_user
	
	# create (post) action for when sign up form is submitted:
	post 'users' => 'users#create'

	#### !CREATE USER ################

	#### USER LOGIN ##################

	# log in page with form:
	get '/login'     => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	
	# delete action to log out:
	delete '/logout' => 'sessions#destroy'

	#### !USER LOGIN ##################
end
