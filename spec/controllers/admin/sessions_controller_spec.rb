require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
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
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy
        expect(session[:admin_user_id]).to be(nil)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy
        expect(response).to redirect_to admin_root_path
      end
    end
  end

  describe 'POST create' do
    context 'with valid username and password' do
      it 'creates the session' do
        admin = FactoryGirl.create(:admin)

        post :create, { :username => admin.username, :password => "Foobar12" }
        expect(session[:admin_user_id]).not_to be(nil)
      end

      it 'redirects to the "orders" action for logged admin' do
        admin = FactoryGirl.create(:admin)

        post :create, { :username => admin.username, :password => "Foobar12" }
        expect(response).to redirect_to admin_orders_path
      end
    end

    context 'with invalid username and/or password' do
      it 'does not create the session' do
        admin = FactoryGirl.create(:admin)

        request.env["HTTP_REFERER"] = "http://test.host"
        post :create, { :username => admin.username, :password => "" }
        expect(session[:admin_user_id]).to be(nil)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)

        request.env["HTTP_REFERER"] = "http://test.host"
        post :create, { :username => admin.username, :password => "" }
        expect(response).to redirect_to :back
      end
    end
  end
end
