class Promotion < ApplicationRecord
	mount_uploader :advert, PromotionUploader

	validates :advert, :title, presence: true
end