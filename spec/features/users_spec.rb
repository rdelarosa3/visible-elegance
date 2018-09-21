require 'rails_helper'

RSpec.feature "Users", type: :feature do

	before(:each) do
		Business.create(name: 'Last', phone: '123456789', zipcode: 1234567, operator: 'john')
	end

 
  	context 'create new user' do 

     	scenario "should be successful" do
	      	visit new_user_path
	      	within("form") do
		        fill_in 'First Name', with: 'john'
		        fill_in 'Last Name', with: 'doe'
		        fill_in 'Email', with: 'example@email.com'
		        fill_in 'Password', with: 'password'
		        fill_in 'Confirm', with: 'password'
      		end
	      	click_button 'Create User'
	      	expect(page).to have_content 'Account created successfully!'
      	end

      	scenario "should fail" do
      		visit new_user_path
	      	within("form") do
		        fill_in 'First Name', with: 'john'
		        fill_in 'Last Name', with: 'doe'
		    end
	      	click_button 'Create User'
	      	expect(page).to have_content 'Email can\'t be blank'
      	end	
    end

    context 'update user' do 
	    scenario "should be successful" do
	      user = User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password')
	      visit edit_user_path(user)
	      within("#userEdit") do
	        fill_in 'First Name', with: 'Jane'
	        fill_in 'Email', with: 'jane.doe@example.com'
	      end
	      click_button 'save'
	      expect(page).to have_content 'User was successfully updated.'
	    
	    end

	    scenario "should fail" do
	      user = User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password',)
	      visit edit_user_path(user)
	      within("#userEdit") do
	        fill_in 'First Name', with: ''
	      end
	      click_button 'save'
	      expect(page).to have_content 'First name is mandatory, please specify one'
	    end
	end
end