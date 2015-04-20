require 'rails_helper'

RSpec.describe Customer::SeatSelectorController, type: :controller do
  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :index

      expect(response).to render_template("index")
    end
  end
end
