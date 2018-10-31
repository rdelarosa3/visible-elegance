class Title < ApplicationRecord	
	has_many :users
	validates :name, presence: true, uniqueness: true

	### custom label for rails admin view ####
  	def custom_label
    "#{self.name}"
    end

end