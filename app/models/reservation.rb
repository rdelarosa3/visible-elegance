class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :service
  
  # create association for stylist with customer on reservation #
  belongs_to :stylist, class_name: 'User'
  
  #validations
  validates :stylist_id, presence: { message: "Stylist not selected." }
  validates :service, presence: { message: "Service not selected." }
  validates :reservation_date, :reservation_time, presence: { message: "Time not selected." }
  validates :phone_number, presence: { message: "Please provide a callback number."}, numericality: { only_integer: true }, length: { minimum: 10, maximum: 15, message: 'Please provide callback number with area code' }
  validate :verify_time
  validate :verify_day
  validate :check_overlapping_appointments,:unless => Proc.new {|c| c.stylist_id.nil? || c.reservation_time.nil? || c.force_create == true}
  before_create :verify_phone

  # custom actions in case update
  after_validation :change_status
  before_update :update_length
  after_update :status_email

  enum status: ["pending","modified","approved","canceled"]

  ################ scopes for search fields ############################

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

    def self.on_date(date)
    Reservation.where("reservation_date = ?" , date)
  end
  def self.date_range(minimum_date,max_date)
    Reservation.where("reservation_date >= ? AND reservation_date <= ?" ,minimum_date,max_date)
  end

  def self.service_name(service)
   Reservation.where("service_id = ?", service)
  end

  ################ VERIFICATIONS ################################

  # verifyies if styliest is working on reservation date
  def verify_day
    if !reservation_date.nil?
      day = self.reservation_date
      if day.strftime("%A") == "Sunday"
          errors.add(:verify_day, "We are closed on Sunday's")
      else
        stylist.off_days.map do |scheduled|
          if day.strftime("%A") == scheduled.day_off
            errors.add(:verify_day, "Stylist not available on this day")
          end
        end
      end
    else
      errors.add(:verify_day, "Please select a date.")
    end
  end

  ### checks customer reservation is between open and close
  def verify_time
    opening = Time.utc(2000,"jan",1,9,30,0)
    closing = Time.utc(2000,"jan",1,18,59,59)

    if reservation_time.strftime("%H%M") > closing.strftime("%H%M") || reservation_time.strftime("%H%M") < opening.strftime("%H%M")
        errors.add(:verify_time, "Choose a time within business hours.")
    end
  end


  # test dates against each other to check overlap
  def overlap?(x,y)

    if self.stylist.appointments.count != 0
      (y.reservation_time.strftime("%H%M")..(y.end_time - (1/1440.0)).strftime("%H%M")).cover?(x.reservation_time.strftime("%H%M")) || (y.reservation_time.strftime("%H%M")..y.end_time.strftime("%H%M")).cover?((x.end_time  - (1/1440.0)).strftime("%H%M"))
    end
  end

  # checks if appointments overlap prior to saving reservation
  def check_overlapping_appointments
    booked_times = ""
    overlapping_times = 
      stylist.appointments.where.not(status: 'canceled').map do |scheduled|
        if self.reservation_date == scheduled.reservation_date  
          if overlap?(self,scheduled)
            if self == scheduled #to allow update of reservation after payment is complete
              return false
            else
              booked_times = "between " + scheduled.reservation_time.strftime("%H:%M").to_s + " - " + scheduled.end_time.strftime("%H:%M").to_s + "."
              true
            end
          end
        end
      end
    .include?(true)
    
    if overlapping_times
      errors.add(:overlapping_appointments, "Our apologies this stylist is already booked #{booked_times} The requested service would require a base time of " + self.service.length.to_s + " minutes.")
    end
  end

  # confirms user has a phone number in saved for their account
  def verify_phone
    user = self.user
    if user.phone_number.nil? || user.phone_number == ""
      user.phone_number = self.phone_number
      user.save
    end
  end

  ################## RESERVATION UPDATES #################################

  # if reservation is updated changes status to modified
  def change_status  
    unless stylist_id_was.nil? || reservation_date_was.nil? || service_id_was.nil? || reservation_time_was.nil?
      if stylist_id_changed? || reservation_date_changed? || service_id_changed? || reservation_time_changed?
        self.status = 'modified'
      end
    end
  end

  # if reservation is updated changes lenght of reservation
  def update_length
    if service_id_changed?  || reservation_time_changed?
      length = self.service.length
      self.end_time = reservation_time + (length * 60)
    end
  end

  #if reservation is updated sends email if status is changed
  def status_email
    update_length
    unless self.pending?
    ReservationMailer.status_email(self).deliver
    end
  end



end
