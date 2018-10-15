class Business < ApplicationRecord
 mount_uploader :logo, LogoUploader
 has_many :business_hours
 validates :name, :phone, :zipcode, :operator, :street, :city, :state, :country, :email, presence: true
 validate :only_one

  private

  def only_one
    if Business.count >= 1
      errors.add :base, 'There can only be one business account.' 
    end
  end



end

