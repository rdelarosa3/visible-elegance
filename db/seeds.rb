# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


dayoff = {}
days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
ActiveRecord::Base.transaction do
	days.length.times do
		dayoff['day_off'] = days.pop
		OffDay.create(dayoff)
		days = days
	end
end


user = {}


ActiveRecord::Base.transaction do

    user['first_name'] = 'admin'
    user['last_name'] = 'admin'
    user['email'] = "admin@admin.com"
    user['role'] = 2
    user['birthday'] = Date.today
    user['password'] = 'admin'
    User.create(user)

end 

user = {}


ActiveRecord::Base.transaction do

    user['first_name'] = 'Walkin'
    user['last_name'] = 'walkin'
    user['email'] = "walkin@email.com"
    user['role'] = 0
    user['birthday'] = Date.today
    user['password'] = '12345678'
    User.create(user)

end 

user = {}


ActiveRecord::Base.transaction do

    user['first_name'] = 'SreyNy'
    user['last_name'] = 'Met'
    user['email'] = "sreyny@email.com"
    user['role'] = 1
    user['birthday'] = Date.today
    user['password'] = '12345678'
    User.create(user)

end 




business = {}


ActiveRecord::Base.transaction do
      business['name'] = "Visible Elegance Hair Salon"
      business['street'] = "115 McCauley Ave"
      business['city'] = "San Antonio"
      business['state'] = "TX"
      business['country'] = "USA"
      business['phone'] = "+1 (210) 924-5700"
      business['zipcode'] = 78211
      business['email'] = "info@visible-elegance.com"
      business['operator'] = "Sandy"
      Business.create(business)
end


service_type = {}
types = ['Hair','Color','Waxing']
ActiveRecord::Base.transaction do
	types.length.times do
	service_type["name"] = types.pop
	ServiceType.create(service_type)
	end
end

service = {}
service_names = ["Up-Do","Haircut - Short","Haircut - Long","Haircut - Medium","Kids - Haircut","Kids - Wash & Dry","Shampoo & Blow-Dry","Shampoo, Blow-Dry & Style"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(3)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(7..50)
		service["length"] = [15,30,60].sample

		Service.create(service)
	end
end


service = {}
service_names = ["Color Retouch","Color Retouch & Haircut","Highlights - Full set","Highlights - Partial","Highlights - Haircut"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(2)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(55..130)
		service["length"] = [60,90,120].sample

		Service.create(service)
	end
end

service = {}
# service_names = ["Color Retouch","Color Retouch & Haircut","Highlights - Full set","Highlights - Partial","Highlights - Haircut"]
service_names = ["Eybrow Maintenance","Eybrow Shaping","Eyebrow Wax","Hairline Removal","Lip Wax","Leg Wax -Full","Leg Wax -Half","Underarm Wax","Back Wax","Arm Wax"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(1)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(7..30)
		service["length"] = [15,30,45].sample

		Service.create(service)
	end
end

hours = {}
opening = Time.utc(2000,"jan",1,9,30,0)
closing = Time.utc(2000,"jan",1,19,00,0)
days = [1,2,3,4,5,6]
	ActiveRecord::Base.transaction do
		days.length.times do
			hours['business_id'] = 1
			hours['day'] = days.pop
			hours['open_time'] = opening.strftime("%H:%M")
			hours['close_time'] = closing.strftime("%H:%M")
			BusinessHour.create(hours)
		end
	end 


title = {}
titles =  ["Stylist", "Senior Stylist", "Makeup Artist", "Nail Tech", "Esthetician", "Massage Therapist", "Reseptionist"]

	ActiveRecord::Base.transaction do
		titles.length.times do
			title['name'] = titles.pop
			Title.create(title)
		end 
	end	