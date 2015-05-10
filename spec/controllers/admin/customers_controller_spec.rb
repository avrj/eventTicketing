require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do
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
      customer = FactoryGirl.create(:customer)
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => customer.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      customer = FactoryGirl.create(:customer)
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => customer.id}

      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "responds successfully with an HTTP 200 status code" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :new

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :new

      expect(response).to render_template("new")
    end
  end

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the customer' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        customer = FactoryGirl.create(:customer)
        delete :destroy, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer) }
        expect(Customer.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        customer = FactoryGirl.create(:customer)
        delete :destroy, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer) }

        expect(response).to redirect_to admin_customers_path
      end
    end
  end

  describe 'DELETE destroy multiple' do
    context 'with valid attributes' do
      it 'destroys the customers' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        customer = FactoryGirl.create(:customer)

        delete :destroy_multiple, {:customer_ids => [customer.id] }
        expect(Customer.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        customer = FactoryGirl.create(:customer)

        delete :destroy_multiple, {:customer_ids => [customer.id] }
        expect(response).to redirect_to admin_customers_path
      end
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the customer' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        customer = FactoryGirl.create(:customer)

        post :create, customer: FactoryGirl.attributes_for(:customer)
        expect(Customer.count).to eq(1)
      end

      it 'redirects to the "show" action for the new customer' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, customer: FactoryGirl.attributes_for(:customer)
        expect(response).to redirect_to admin_customer_path(Customer.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the customer' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, customer: FactoryGirl.attributes_for(:customer, firstname: "x")
        expect(Customer.count).to eq(0)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, customer: FactoryGirl.attributes_for(:customer, firstname: "x")
        expect(response).to render_template :new
      end
    end
  end

describe 'POST update' do
  context 'without new passwords' do
    it "updates only contact information" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "", password_confirmation: "")}
      expect(Customer.last.postcode).to eq("11111")
    end

    it 'redirects to the "show" action for the updated customer' do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "", password_confirmation: "")}
      expect(response).to redirect_to admin_customer_path(customer)
    end
  end



  context 'with different new passwords' do
    it "does not update the contact information and password" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "Testi1323A", password_confirmation: "Testi123A")}
      expect(Customer.last.authenticate("Foobar12")).not_to be(nil)
      expect(Customer.last.postcode).not_to eq("11111")
    end

    it 're-renders the "edit" view' do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "Testi1323A", password_confirmation: "Testi123A")}
      expect(response).to render_template :edit
    end
  end

  context 'with matching new passwords' do
    it "updates the contact information and password" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "Testi123A", password_confirmation: "Testi123A")}
      expect(Customer.last.authenticate("Testi123A")).not_to be(nil)
    end

    it 'redirects to the "show" action for the updated customer' do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      put :update, {:id => customer.id, :customer => FactoryGirl.attributes_for(:customer, postcode: "11111", password: "Testi123A", password_confirmation: "Testi123A")}
      expect(response).to redirect_to admin_customer_path(customer)
    end
  end
end
  end