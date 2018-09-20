class Reservation < ApplicationRecord
  belongs_to :user
  # create association for stylist with customer on reservation #
  belongs_to :stylist, class_name: 'User'
  belongs_to :service
  validates :reservation_date, presence: true
  validates :reservation_time, presence: true
  validates :service, presence: true
  # 
  enum status: ["Pending","Approved"]

  # scopes for search fields #
  def self.current_date
  	current_date = DateTime.now
  	Reservation.where("reservation_date >= ?", current_date)
  end

  def self.past_date
  	current_date = DateTime.now
  	Reservation.where("reservation_date < ?", current_date)
  end

  def self.stylist_name(stylist)
    Reservation.where("stylist_id = ?", stylist)
  end

   def self.date_range(minimum_date,max_date)
    Reservation.where("reservation_date >= ? AND reservation_date <= ?" ,minimum_date,max_date)
   end

   def self.service_name(service)
   Reservation.where("service_id = ?", service)
 end

end
