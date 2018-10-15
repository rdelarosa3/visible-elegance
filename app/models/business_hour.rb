class BusinessHour < ApplicationRecord
  belongs_to :business
  enum day: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
  validates :open_time, :close_time, :day, presence: true
  validates_uniqueness_of :day

  # validate :operator?, on: [:create, :update, :destroy]

  ### custom label for rails admin view ####
  	def custom_label
    "#{self.day}"
    end

end
