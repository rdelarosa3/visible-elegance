require 'rails_helper'

RSpec.describe User, type: :model do
	####### validations	###########
   context 'validation tests' do
    it 'ensures first name presence' do
      user = User.new(last_name: 'Last', email: 'sample@example.com').save
      expect(user).to eq(false)
    end
    
    it 'ensures last name presence' do
      user = User.new(first_name: 'First', email: 'sample@example.com').save
      expect(user).to eq(false)
    end
    
    it 'ensures email presence' do
      user = User.new(first_name: 'First', last_name: 'Last').save
      expect(user).to eq(false)
    end
    
    it 'ensures passowrd presence' do 
      user = User.new(first_name: 'First', last_name: 'Last', email: 'email@example.com').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do 
      user = User.new(first_name: 'First', last_name: 'Last', email: 'email@example.com', password: SecureRandom.hex(10)).save
      expect(user).to eq(true)
    end
  end

 #  #### custom method test need validations commented out for test ###
  context 'scope tests' do
  
    let (:params) { {first_name: 'First', last_name: 'Last', password: SecureRandom.hex(10)} }
    before(:each) do
      User.new(params.merge(email: 'smpl@example.com')).save
      User.new(params.merge(email: 'saml@example.com')).save
      User.new(params.merge(role: "admin", email: 'sampler@example.com')).save
      User.new(params.merge(role: "admin", email: 'ampl@example.com')).save
      User.new(params.merge(role: "admin", email: 'sampl@example.com')).save
    end

    it 'should return customers' do
      expect(User.client.count).to eq(2)
    end

    it 'should return admins' do
      expect(User.stylist.count).to eq(3)
    end
  end

  context 'associations tests' do
    it "should have many reservations" do
      t = User.reflect_on_association(:reservations)
      expect(t.macro).to eq(:has_many)
    end

    it "should have many appointments" do
      t = User.reflect_on_association(:appointments)
      expect(t.macro).to eq(:has_many)
    end
  end

end
