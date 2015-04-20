require 'rails_helper'

RSpec.describe Seat, type: :model do
  let(:seat){ FactoryGirl.create(:seat) }

  describe "with proper fields" do
    it "is saved" do
      expect(seat).to be_valid
      expect(Seat.count).to eq(1)
    end
  end
end
