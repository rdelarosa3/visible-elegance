# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}


ActiveRecord::Base.transaction do

    user['first_name'] = 'admin'
    user['last_name'] = 'admin'
    user['email'] = "admin@admin.com"
    user['role'] = 1
    user['birthday'] = Date.today
    user['password'] = 'admin'
    User.create(user)

end 