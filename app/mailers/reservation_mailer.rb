class ReservationMailer < ApplicationMailer
	
	def status_email(reservation)
      @reservation = reservation
      @user = reservation.user
       
      if reservation.approved?
       mail(to: @user.email, subject: "Visible Elegance Reservation Approved") 
   	  else
   	   mail(to: @user.email, subject: "Visible Elegance Reservation Updated")
   	  end

	end

	def request_email()

	end

	def pending_request()

	end
end
