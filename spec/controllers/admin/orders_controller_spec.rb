require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "responds successfully with an HTTP 200 status code" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)
      get :show, {:id => reservation.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)

      get :show, {:id => reservation.id}

      expect(response).to render_template("show")
    end
  end

  describe "GET edit" do
    it "responds successfully with an HTTP 200 status code" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)
      get :edit, {:id => reservation.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      customer = FactoryGirl.create(:customer)
      reservation = FactoryGirl.create(:reservation, customer: customer)

      get :edit, {:id => reservation.id}

      expect(response).to render_template("edit")
    end
  end
end
