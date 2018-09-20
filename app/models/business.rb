class Business < ApplicationRecord
 mount_uploader :logo, LogoUploader
 has_many :business_hours
 validates :name, presence: true
 validates :phone, presence: true
 validates :zipcode, presence: true
 validates :operator, presence: true
end

