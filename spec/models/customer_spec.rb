require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer){ FactoryGirl.create(:customer) }

  describe "with a proper password" do

    it "is saved" do
      expect(customer).to be_valid
      expect(Customer.count).to eq(1)
    end
  end
end
