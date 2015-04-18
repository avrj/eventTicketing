require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "with a proper fields" do
    let(:ticket){ FactoryGirl.create(:ticket) }

    it "is saved" do
      expect(ticket).to be_valid
      expect(Ticket.count).to eq(1)
    end
  end
end
