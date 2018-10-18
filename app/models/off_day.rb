class OffDay < ApplicationRecord	
	
	has_many :schedules
	has_many :users, through: :schedules
	enum day_off: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
	validates :day_off, presence: true, uniqueness: true

	  ### custom label for rails admin view ####
  	def custom_label
    "#{self.day_off}"
    end

end