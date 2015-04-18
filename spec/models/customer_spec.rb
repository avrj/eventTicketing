require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "with a proper password" do
    let(:customer){ FactoryGirl.create(:customer) }

    it "is saved" do
      expect(customer).to be_valid
      expect(Customer.count).to eq(1)
    end
  end
end
