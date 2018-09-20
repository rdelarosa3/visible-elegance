require 'rails_helper'

RSpec.describe Reservation, type: :model do

  context 'associations tests' do
    it "should belong to user" do
      t = Reservation.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it "should belong to stylist" do
      t = Reservation.reflect_on_association(:stylist)
      expect(t.macro).to eq(:belongs_to)
    end

      it "should belong to service" do
      t = Reservation.reflect_on_association(:service)
      expect(t.macro).to eq(:belongs_to)
    end
  end

end