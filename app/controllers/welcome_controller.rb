class WelcomeController < ApplicationController
	def homepage
	  	@staff = User.all.where(role: :admin)
	  	@service_types = ServiceType.all.order('name ASC')
	  	@reservation = Reservation.new
  	end
end
