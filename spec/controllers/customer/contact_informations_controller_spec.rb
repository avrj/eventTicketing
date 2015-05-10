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

      expect(response).to render_template :edit
    end
  end

  describe 'POST update' do
    context 'with correct password and without new passwords' do
      it "updates only contact information" do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "", password_confirmation: "")}
        expect(Customer.last.postcode).to eq("11111")
      end

      it 'redirects to the "show" action for the updated customer' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "", password_confirmation: "")}
        expect(response).to redirect_to customer_contact_information_path
      end
    end



    context 'with correct password and different new passwords' do
      it "does not update the contact information and password" do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "Testi1323A", password_confirmation: "Testi123A")}
        expect(Customer.last.authenticate("Foobar12")).not_to be(nil)
        expect(Customer.last.postcode).not_to eq("11111")
      end

      it 're-renders the "edit" view' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "Testi1323A", password_confirmation: "Testi123A")}
        expect(response).to render_template :edit
      end
    end

    context 'with correct password and matching new passwords' do
      it "updates the contact information and password" do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "Testi123A", password_confirmation: "Testi123A")}
        expect(Customer.last.authenticate("Testi123A")).not_to be(nil)
      end

      it 'redirects to the "show" action for the updated customer' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        put :update, {:customer => FactoryGirl.attributes_for(:customer, postcode: "11111", current_password: "Foobar12", password: "Testi123A", password_confirmation: "Testi123A")}
        expect(response).to redirect_to customer_contact_information_path
      end
    end

    context 'with invalid password' do
      it 'redirects back' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        request.env["HTTP_REFERER"] = "http://test.host/customer/contact_information/edit"
        put :update, {:current_password => "xx", :customer => FactoryGirl.attributes_for(:customer)}
        expect(response).to redirect_to :back
      end
    end
  end
end
