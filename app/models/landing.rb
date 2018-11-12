class Landing < ApplicationRecord
	mount_uploader :image, LandingUploader

	validates :image, :title, presence: true
end