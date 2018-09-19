class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :stylist, class_name: 'User'
  belongs_to :service
  validates :reservation_date, presence: true
  validates :reservation_time, presence: true
  validates :service, presence: true
  enum status: ["Pending","Approved"]


  def self.current_date
  	current_date = DateTime.now
  	Reservation.where("reservation_date >= ?", current_date)
  end

  def self.past_date
  	current_date = DateTime.now
  	Reservation.where("reservation_date < ?", current_date)
  end
end
