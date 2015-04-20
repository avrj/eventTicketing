require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin){ FactoryGirl.create(:admin) }

  describe "with a proper password" do

    it "is saved" do
      expect(admin).to be_valid
      expect(Admin.count).to eq(1)
    end
  end
end
