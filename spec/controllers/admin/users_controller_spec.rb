require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
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

      get :show, {:id => admin.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => admin.id}

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

  describe "GET edit" do
    it "responds successfully with an HTTP 200 status code" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => admin.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => admin.id}

      expect(response).to render_template("edit")
    end
  end

  # TODO: allowed only for admin level 1

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, admin: FactoryGirl.attributes_for(:admin, username: "eri")
        expect(Admin.count).to eq(2)
      end

      it 'redirects to the "show" action for the new admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, admin: FactoryGirl.attributes_for(:admin, username: "eri")
        expect(response).to redirect_to admin_user_path(Admin.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, admin: FactoryGirl.attributes_for(:admin, username: nil)
        expect(Admin.count).to eq(1)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, admin: FactoryGirl.attributes_for(:admin, username: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST update' do
    context 'with valid attributes' do
      it 'updates the admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        put :update, {:id => admin.id, :admin => FactoryGirl.attributes_for(:admin)}
        expect(Admin.count).to eq(1)
      end

      it 'redirects to the "show" action for the updated admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        put :update, {:id => admin.id, :admin => FactoryGirl.attributes_for(:admin)}
        expect(response).to redirect_to admin_user_path(Admin.last)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the "edit" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        put :update, {:id => admin.id, :admin => FactoryGirl.attributes_for(:admin, username: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the admin' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy, {:id => admin.id, :admin => FactoryGirl.attributes_for(:admin) }
        expect(Admin.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy, {:id => admin.id, :admin => FactoryGirl.attributes_for(:admin) }
        expect(response).to redirect_to admin_users_path
      end
    end
  end

  describe 'DELETE destroy multiple' do
    context 'with valid attributes' do
      it 'destroys the admins' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy_multiple, {:admin_ids => [admin.id]}
        expect(Admin.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        delete :destroy_multiple, {:admin_ids => [admin.id]}
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end
