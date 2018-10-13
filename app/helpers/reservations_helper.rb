module ReservationsHelper
	
  def pending_reservations
    Reservation.where(status: 'pending').count
  end
end
