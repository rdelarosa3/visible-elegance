class Service < ApplicationRecord
	has_many :reservations
	belongs_to :service_type
end
