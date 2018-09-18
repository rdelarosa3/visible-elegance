Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	# Add a root route if you don't have one...
	####
	root to: 'users#new'
  	
  	#### CREATE ACCOUNT ################
  	get '/registration' => 'users#new', as: :sign_up
	# create (post) action for when sign up form is submitted:
	post 'users' => 'users#create'

	#### USER LOGIN ##################

	# log in page with form:
	get '/login'  => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login' => 'sessions#create'
	
	# delete action to log out:
	delete '/logout' => 'sessions#destroy'


	####  OMNIAUTH LOGIN ####
	get "/auth/:provider/callback" => "sessions#create_from_omniauth"

end
