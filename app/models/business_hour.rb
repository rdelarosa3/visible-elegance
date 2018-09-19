class BusinessHour < ApplicationRecord
  belongs_to :business
  enum day: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
  validates :open_time, presence: true
  validates :close_time, presence: true
  validates_uniqueness_of :day

  	def custom_label
    "#{self.day}"
    end
end
