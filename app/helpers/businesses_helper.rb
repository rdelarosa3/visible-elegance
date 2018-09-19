module BusinessesHelper

	def business_info
		@business = Business.find(1)
	end
end
