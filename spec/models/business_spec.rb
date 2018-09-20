require 'rails_helper'

RSpec.describe Business, type: :model do
	# ####### validations	###########
   context 'validation tests' do
	    it 'ensures name presence' do
	      user = Business.new(phone: '123456789', zipcode: 1234567, operator: 'john').save
	      expect(user).to eq(false)
	    end
	    
	    it 'ensures phone presence' do
	      user = Business.new(name: 'Last', zipcode: 1234567, operator: 'john').save
	      expect(user).to eq(false)
	    end
	    
	    it 'ensures zipcode presence' do
	      user = Business.new(name: 'Last', phone: '123456789', operator: 'john').save
	      expect(user).to eq(false)
	    end
	    
	    it 'ensures operator presence' do 
	      user = Business.new(name: 'Last', phone: '123456789', zipcode: 1234567).save
	      expect(user).to eq(false)
	    end

	    it 'should save successfully' do 
	      user = Business.new(name: 'Last', phone: '123456789', zipcode: 1234567, operator: 'john').save
	      expect(user).to eq(true)
	    end
	end
end