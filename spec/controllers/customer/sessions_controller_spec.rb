require 'rails_helper'

RSpec.describe Customer::SessionsController, type: :controller do
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

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the session' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        delete :destroy
        expect(session[:admin_customer_id]).to be(nil)
      end

      it 'redirects to the "index" action' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        delete :destroy
        expect(response).to redirect_to :root
      end
    end
  end

  describe 'POST create' do
    context 'with valid username and password' do
      it 'creates the session' do
        customer = FactoryGirl.create(:customer)

        post :create, customer: FactoryGirl.attributes_for(:customer, password: "Foobar12")
        expect(session[:customer_user_id]).not_to be(nil)
      end

      it 'redirects to the "orders" action for logged customer' do
        customer = FactoryGirl.create(:customer)

        post :create, customer: FactoryGirl.attributes_for(:customer, password: "Foobar12")
        expect(response).to redirect_to customer_orders_path
      end
    end

    context 'with invalid username and/or password' do
      it 'does not create the session' do
        customer = FactoryGirl.create(:customer)

        request.env["HTTP_REFERER"] = "http://test.host"
        post :create, customer: FactoryGirl.attributes_for(:customer, password: "")
        expect(session[:customer_user_id]).to be(nil)
      end

      it 're-renders the "new" view' do
        customer = FactoryGirl.create(:customer)

        request.env["HTTP_REFERER"] = "http://test.host"
        post :create, customer: FactoryGirl.attributes_for(:customer, password: "")
        expect(response).to redirect_to :back
      end
    end
  end
end
