class Service < ApplicationRecord
	has_many :reservations
	belongs_to :service_type

	#Service to stylist Association
    has_many :skills
    has_many :users, through: :skills
	validates :name, presence: true, uniqueness: true

end
