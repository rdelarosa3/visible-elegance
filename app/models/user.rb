class User < ApplicationRecord
	has_secure_password
	has_many :authentications, dependent: :destroy
	has_many :reservations
	has_many :appointments, :class_name => 'Reservation', :foreign_key => 'stylist_id'

	
	#Service to stylist Association
    has_many :skills
    has_many :services, through: :skills


	enum role: ["customer","admin","operator"]
	mount_uploader :avatar, AvatarUploader

	# Verifies that email field is not blank and that it prevents duplicates#
	validates :email, uniqueness: true
	validates :last_name, :last_name, :email, presence: true
	validates :gender, presence: true, on: :update
	validates :phone_number, numericality: { only_integer: true }, on: :update

	# Oauth USER creation #####
	def self.create_with_auth_and_hash(authentication, auth_hash)
		# in case of login in through facebook is added
		birthday = auth_hash['extra']['raw_info']["birthday"]
		if birthday.nil?
	     	birthday = Date.new(1970,1,1)
	    end
	    gender = auth_hash['extra']['raw_info']['gender']
	    if gender.nil?
	    	gender = "unknown"
	    end

		user = self.create!(
		 email: auth_hash["info"]["email"],
		 first_name: auth_hash["info"]["first_name"],
	     last_name: auth_hash["info"]["last_name"], 
         birthday: birthday,
         gender: gender,
	     phone_number: auth_hash["info"]["phone"],
		 password: SecureRandom.hex(10),
		 remote_avatar_url: auth_hash["info"]["image"]
		)
		user.authentications << authentication
		return user
	end


	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end

	def fullname
		[first_name, last_name].join(' ')
	end

	# title to create relation for booking appointment
	def self.stylist
  		User.where(role: :admin)
  	end

  	# scope to find customers 
  	def self.client
  		User.where(role: :customer)
  	end

  	##### admin panel custom label ######
	def custom_label_method
    "#{self.email}"
    end

end
