require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe "with a proper name, description and price" do
    let(:ticket_type){ FactoryGirl.create(:ticket_type) }

    it "is saved" do
      expect(ticket_type).to be_valid
      expect(TicketType.count).to eq(1)
    end
  end
end
