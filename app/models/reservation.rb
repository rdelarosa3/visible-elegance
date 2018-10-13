class Reservation < ApplicationRecord
  belongs_to :user
  # create association for stylist with customer on reservation #
  belongs_to :stylist, class_name: 'User'
  belongs_to :service
  validates :stylist_id, presence: true
  validates :reservation_date, presence: true
  validates :reservation_time, presence: true
  validates :service, presence: true
  validate :verify_time
  validate :check_overlapping_appointments
   
  enum status: ["pending","approved"]

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

 ### checks customer reservation between open and close
  def verify_time
    opening = Time.utc(2000,"jan",1,9,30,0)
    closing = Time.utc(2000,"jan",1,18,59,59)
   
    if reservation_time.strftime("%H%M") > closing.strftime("%H%M") || reservation_time.strftime("%H%M") < opening.strftime("%H%M")
        errors.add(:verify_time, "Pick a new time")
    end
  end


  # test if appointments overlap prior to saving reservation
  def check_overlapping_appointments
    overlapping_times = 
      stylist.appointments.map do |scheduled|
        if self.reservation_date == scheduled.reservation_date  
          if overlap?(self,scheduled)
            if self == scheduled #to allow update of reservation after payment is complete
              return false
            else
              true
            end
          end
        end
      end
    .include?(true)
    
    if overlapping_times
      errors.add(:overlapping_appointments, "Stylist is not available")
    end
  end



  # test dates against each other to check overlap
  def overlap?(x,y)
    
    if self.stylist.appointments.count != 0
      (y.reservation_time.strftime("%H%M")..y.end_time.strftime("%H%M")).cover?(x.reservation_time.strftime("%H%M")) || (y.reservation_time.strftime("%H%M")..y.end_time.strftime("%H%M")).cover?(x.end_time.strftime("%H%M"))
    end
  end


end
