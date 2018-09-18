class User < ApplicationRecord
	has_secure_password
	has_many :authentications, dependent: :destroy


	# Verifys that email field is not blank and that it doesn't already exist in the db (prevents duplicates)#
	validates :email, presence: true, uniqueness: true


	# Oauth USER creation #####
	def self.create_with_auth_and_hash(authentication, auth_hash)
		# in case of loggin in through facebook
		# birthday = auth_hash['extra']['raw_info']["birthday"]
		# if birthday.nil?
	 #     	birthday = Date.new(1970,1,1)
	 #    end
	 #    gender = auth_hash['extra']['raw_info']['gender']
	 #    if gender.nil?
	 #    	gender = "unknown"
	 #    end

		user = self.create!(
		 email: auth_hash["info"]["email"],
		 name: auth_hash["info"]["first_name"],
	     # last_name: auth_hash["info"]["last_name"], 
      #    birthday: birthday,
      #    gender: gender,
	     # phone_number: auth_hash["info"]["phone"],
		 password: SecureRandom.hex(10),
		 # remote_avatar_url: auth_hash["info"]["image"]
		)
		user.authentications << authentication
		return user
	end


	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end
end
