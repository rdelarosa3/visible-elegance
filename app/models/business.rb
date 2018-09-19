class Business < ApplicationRecord
 mount_uploader :logo, LogoUploader
 has_many :business_hours
end
