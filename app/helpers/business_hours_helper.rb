module BusinessHoursHelper
	
	# Show user if business is open in view #
	def open_now?
		start = '09:30'
		close = '19:00'
		Time.zone = 'Central Time (US & Canada)'
		current_time = Time.zone.now
		opened = current_time.strftime('%H:%M')


		if opened.between?(start ,close)
			if current_time.strftime("%A") != 'Sunday'
				true # '"Open Now"'
			end
		end
	end
	
end
