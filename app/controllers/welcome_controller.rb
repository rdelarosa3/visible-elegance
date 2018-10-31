class WelcomeController < ApplicationController
	def homepage
	  	@staff = User.all.where.not(role: :customer)
	  	@service_types = ServiceType.all.order('name ASC')
	  	@reservation = Reservation.new
	  	@user = User.new
  	end
end
