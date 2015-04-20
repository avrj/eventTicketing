require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "assigned to customer" do
    it "is saved" do
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)

      expect(reservation).to be_valid
      expect(Reservation.count).to eq(1)
    end
  end

  describe "total price" do
    it "has method for determining it" do
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)

      expect(reservation).to respond_to(:total)
    end

    it "equals zero without tickets" do
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)

      expect(reservation.total).to eq(0)
    end

    it "equals ticket's price with one ticket in reservation" do
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)
      ticket_type = FactoryGirl.create(:ticket_type)
      ticket = FactoryGirl.create(:ticket, reservation: reservation, ticket_type: ticket_type)

      expect(reservation.total).to eq(ticket.ticket_type.price)
    end
  end
end
