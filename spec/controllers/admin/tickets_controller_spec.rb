require 'rails_helper'

RSpec.describe Admin::TicketsController, type: :controller do
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
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => ticket.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      ticket_type = FactoryGirl.create(:ticket_type)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :show, {:id => ticket.id}

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
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => ticket.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      ticket_type = FactoryGirl.create(:ticket_type)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      get :edit, {:id => ticket.id}

      expect(response).to render_template("edit")
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        post :create, ticket: FactoryGirl.attributes_for(:ticket, ticket_type_id: ticket_type.id)
        expect(Ticket.count).to eq(1)
      end

      it 'redirects to the "show" action for the new ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)

        post :create, ticket: FactoryGirl.attributes_for(:ticket, ticket_type_id: ticket_type.id)
        expect(response).to redirect_to admin_ticket_path(Ticket.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket: FactoryGirl.attributes_for(:ticket)
        expect(Ticket.count).to eq(0)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, ticket: FactoryGirl.attributes_for(:ticket)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST update' do
    context 'with valid attributes' do
      it 'updates the ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

        put :update, {:id => ticket.id, :ticket => FactoryGirl.attributes_for(:ticket, ticket_type_id: ticket_type.id) }
        expect(Ticket.count).to eq(1)
      end

      it 'redirects to the "show" action for the updated ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

        put :update, {:id => ticket.id, :ticket => FactoryGirl.attributes_for(:ticket, ticket_type_id: ticket_type.id) }
        expect(response).to redirect_to admin_ticket_path(Ticket.last)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the "edit" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

        put :update, {:id => ticket.id, :ticket => FactoryGirl.attributes_for(:ticket, ticket_type_id: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

        delete :destroy, {:id => ticket.id, :ticket => FactoryGirl.attributes_for(:ticket) }
        expect(Ticket.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

        delete :destroy, {:id => ticket.id, :ticket => FactoryGirl.attributes_for(:ticket) }
        expect(response).to redirect_to admin_tickets_path
      end
    end
  end
end
