require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket_type){ FactoryGirl.create(:ticket_type) }
  let(:ticket){ FactoryGirl.create(:ticket, ticket_type: ticket_type) }

  describe "with a proper fields" do
    it "is saved" do
      expect(ticket).to be_valid
      expect(Ticket.count).to eq(1)
    end
  end
end
