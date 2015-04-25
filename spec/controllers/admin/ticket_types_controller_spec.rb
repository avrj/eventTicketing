require 'rails_helper'

RSpec.describe Admin::TicketTypesController, type: :controller do
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
      ticket_type = FactoryGirl.create(:ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => ticket_type.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      ticket_type = FactoryGirl.create(:ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => ticket_type.id}

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
      ticket_type = FactoryGirl.create(:ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => ticket_type.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      ticket_type = FactoryGirl.create(:ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => ticket_type.id}

      expect(response).to render_template("edit")
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket_type: FactoryGirl.attributes_for(:ticket_type)
        expect(TicketType.count).to eq(1)
      end

      it 'redirects to the "show" action for the new ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket_type: FactoryGirl.attributes_for(:ticket_type)
        expect(response).to redirect_to admin_ticket_type_path(TicketType.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket_type: FactoryGirl.attributes_for(:ticket_type, name: nil)
        expect(TicketType.count).to eq(0)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket_type: FactoryGirl.attributes_for(:ticket_type, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST update' do
    context 'with valid attributes' do
      it 'updates the ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        put :update, {:id => ticket_type.id, :ticket_type => FactoryGirl.attributes_for(:ticket_type)}
        expect(TicketType.count).to eq(1)
      end

      it 'redirects to the "show" action for the updated ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        put :update, {:id => ticket_type.id, :ticket_type => FactoryGirl.attributes_for(:ticket_type)}
        expect(response).to redirect_to admin_ticket_type_path(TicketType.last)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the "edit" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        put :update, {:id => ticket_type.id, :ticket_type => FactoryGirl.attributes_for(:ticket_type, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the ticket type' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        delete :destroy, {:id => ticket_type.id, :ticket_type => FactoryGirl.attributes_for(:ticket_type) }
        expect(TicketType.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        delete :destroy, {:id => ticket_type.id, :ticket_type => FactoryGirl.attributes_for(:ticket_type) }
        expect(response).to redirect_to admin_ticket_types_path
      end
    end
  end
end
