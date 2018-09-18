Rails.application.routes.draw do
	
	root 'welcome#homepage'

  resources :users
  	
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
