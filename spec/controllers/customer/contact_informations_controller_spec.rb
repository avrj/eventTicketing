require 'rails_helper'

RSpec.describe Customer::ContactInformationsController, type: :controller do
  describe "GET show" do
    it "responds successfully with an HTTP 200 status code" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :show

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :show

      expect(response).to render_template("show")
    end
  end

  describe "GET edit" do
    it "responds successfully with an HTTP 200 status code" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :edit

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :edit

      expect(response).to render_template("edit")
    end
  end
end
