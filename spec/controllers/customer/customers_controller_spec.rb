require 'rails_helper'

RSpec.describe Customer::CustomersController, type: :controller do
  describe "GET new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the customer' do
        post :create, customer: FactoryGirl.attributes_for(:customer)
        expect(Customer.count).to eq(1)
      end

      it 'redirects to the "show" action for the new customer' do
        post :create, {:customer => FactoryGirl.attributes_for(:customer), :redirect => ""}
        expect(response).to redirect_to shopping_cart_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create the customer' do
        post :create, customer: FactoryGirl.attributes_for(:customer, firstname: "x")
        expect(Customer.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, customer: FactoryGirl.attributes_for(:customer, firstname: "x")
        expect(response).to render_template :new
      end
    end
  end
end