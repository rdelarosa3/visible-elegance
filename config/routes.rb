Rails.application.routes.draw do
	default_url_options :host => "ve-salon.herokuapp.com"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	root 'welcome#homepage'
	resources :business_hours
	resources :service_types
	resources :services
	resources :contents
	resources :businesses
	resources :reservations
	resources :users
	resources :stamps

	get '/users/:id/edit'  => 'edit#user', as: :update_user
  	
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

	##### CONTACT US PAGE ####
	get '/contact' => 'reservations#new', as: :contact_us

	##### reservation update status #####
	post '/reservations/:id(.:format)' => "reservations#status_change", as: :status_change
	# patch '/reservations/:id(.:format)' => "reservations#status_change"
	get '/autofill' => 'reservations#autofill'

	get '/schedule' => 'reservations#schedule'

	delete '/rewards' => "stamps#reset_loyalty", as: :redeem_card
	post '/stamp' => "stamps#stamp", as: :stamp_card
end
