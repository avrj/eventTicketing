require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe "with a proper name, description and price" do
    let(:ticket_type){ FactoryGirl.create(:ticket_type) }

    it "is saved" do
      expect(ticket_type).to be_valid
      expect(TicketType.count).to eq(1)
    end
  end

  describe "free tickets" do
    it "has method for getting free tickets" do
      ticket_type = FactoryGirl.create(:ticket_type)

      expect(ticket_type).to respond_to(:free)
    end

    it "contains one ticket if reservation contains one free ticket" do
      ticket_type = FactoryGirl.create(:ticket_type)
      free_ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      expect(ticket_type.free.count).to eq(1)
    end

    it "doesn't contain tickets if reservation contains one reserved ticket" do
      ticket_type = FactoryGirl.create(:ticket_type)
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)
      reserved_ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, reservation: reservation)

      expect(ticket_type.free.count).to eq(0)
    end
  end

  describe "reserved tickets" do
    it "has method for getting reserved tickets" do
      ticket_type = FactoryGirl.create(:ticket_type)

      expect(ticket_type).to respond_to(:reserved)
    end

    it "contains one ticket if reservation contains one reserved ticket" do
      ticket_type = FactoryGirl.create(:ticket_type)
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)
      reserved_ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, reservation: reservation)

      expect(ticket_type.reserved.count).to eq(1)
    end

    it "doesn't contain tickets if reservation contains one free ticket" do
      ticket_type = FactoryGirl.create(:ticket_type)
      free_ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      expect(ticket_type.reserved.count).to eq(0)
    end
  end
end
