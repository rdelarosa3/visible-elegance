module BusinessesHelper
	
	# place business public info in views
	def business_info
		@business = Business.first
	end
end
