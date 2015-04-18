require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "with a proper customer" do
    let(:reservation){ FactoryGirl.create(:reservation) }

    it "is saved" do
      expect(reservation).to be_valid
      expect(Reservation.count).to eq(1)
    end
  end
end
