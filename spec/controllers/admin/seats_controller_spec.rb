require 'rails_helper'

RSpec.describe Admin::SeatsController, type: :controller do
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
      ticket_type = FactoryGirl.create(:ticket_type_seat)
      seat = FactoryGirl.create(:seat)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

      get :show, {:id => seat.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      ticket_type = FactoryGirl.create(:ticket_type_seat)
      seat = FactoryGirl.create(:seat)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

      get :show, {:id => seat.id}

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
      ticket_type = FactoryGirl.create(:ticket_type_seat)
      seat = FactoryGirl.create(:seat)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)
      get :edit, {:id => seat.id}

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id
      ticket_type = FactoryGirl.create(:ticket_type_seat)
      seat = FactoryGirl.create(:seat)
      ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

      get :edit, {:id => seat.id}

      expect(response).to render_template("edit")
    end
  end


  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates the seat' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type_seat)
        post :create, seat: FactoryGirl.attributes_for(:seat, ticket_type: ticket_type)
        expect(Seat.count).to eq(1)
      end

      it 'redirects to the "show" action for the new seat' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type_seat)
        post :create, seat: FactoryGirl.attributes_for(:seat, ticket_type: ticket_type)
        expect(response).to redirect_to admin_seat_path(Seat.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the seat' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, seat: FactoryGirl.attributes_for(:seat)
        expect(Seat.count).to eq(0)
      end

      it 're-renders the "new" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        post :create, seat: FactoryGirl.attributes_for(:seat, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST update' do
    context 'with valid attributes' do
      it 'updates the seat' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type_seat)
        seat = FactoryGirl.create(:seat)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

        put :update, {:id => seat.id, :seat => FactoryGirl.attributes_for(:seat)}
        expect(TicketType.count).to eq(1)
      end

      it 'redirects to the "show" action for the updated seat' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type_seat)
        seat = FactoryGirl.create(:seat)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

        put :update, {:id => seat.id, :seat => FactoryGirl.attributes_for(:seat, ticket_type: ticket_type)}
        expect(response).to redirect_to admin_seat_path(Seat.last)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the "edit" view' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        ticket_type = FactoryGirl.create(:ticket_type_seat)
        seat = FactoryGirl.create(:seat)
        ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type, seat: seat)

        put :update, {:id => seat.id, :seat => FactoryGirl.attributes_for(:seat, ticket_type: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid attributes' do
      it 'destroys the seat and ticket' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type_seat)
        ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

        delete :destroy, {:id => seat.id, :seat => FactoryGirl.attributes_for(:seat) }
        expect(Seat.count).to eq(0)
        expect(Ticket.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type_seat)
        ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

        delete :destroy, {:id => seat.id, :seat => FactoryGirl.attributes_for(:seat) }
        expect(response).to redirect_to admin_seats_path
      end
    end
  end

  describe 'DELETE destroy multiple' do
    context 'with valid attributes' do
      it 'destroys the seats and tickets' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type_seat)
        ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

        delete :destroy_multiple, {:seat_ids => [seat.id] }
        expect(Seat.count).to eq(0)
        expect(Ticket.count).to eq(0)
      end

      it 'redirects to the "index" action' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type_seat)
        ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

        delete :destroy_multiple, {:seat_ids => [seat.id] }
        expect(response).to redirect_to admin_seats_path
      end
    end
  end

  describe 'POST toggle_given_away' do
    context 'with a seat that is already given away' do
      it 'changes the seat to not given away' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, seat: seat, given_away: true, ticket_type: ticket_type)

        request.env['HTTP_REFERER'] = "http://test.host/admin/seats/new"
        post :toggle_given_away, {:seat_id => seat.id}
        expect(Ticket.find_by(seat: seat).given_away).to eq(false)
      end

      it 'redirects to back' do
        admin = FactoryGirl.create(:admin)
        session[:admin_user_id] = admin.id

        seat = FactoryGirl.create(:seat)
        ticket_type = FactoryGirl.create(:ticket_type)
        ticket = FactoryGirl.create(:ticket, seat: seat, given_away: true, ticket_type: ticket_type)

        request.env['HTTP_REFERER'] = "http://test.host/admin/seats/new"
        post :toggle_given_away, {:seat_id => seat.id}
        expect(response).to redirect_to :back
      end
    end

  context 'with a seat that is not yet given away' do
    it 'changes the seat to given away' do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      seat = FactoryGirl.create(:seat)
      ticket_type = FactoryGirl.create(:ticket_type)
      ticket = FactoryGirl.create(:ticket, seat: seat, given_away: false, ticket_type: ticket_type)

      request.env['HTTP_REFERER'] = "http://test.host/admin/seats/new"
      post :toggle_given_away, {:seat_id => seat.id}
      expect(Ticket.find_by(seat: seat).given_away).to eq(true)
    end

    it 'redirects to back' do
      admin = FactoryGirl.create(:admin)
      session[:admin_user_id] = admin.id

      seat = FactoryGirl.create(:seat)
      ticket_type = FactoryGirl.create(:ticket_type)
      ticket = FactoryGirl.create(:ticket, seat: seat, given_away: false, ticket_type: ticket_type)

      request.env['HTTP_REFERER'] = "http://test.host/admin/seats/new"
      post :toggle_given_away, {:seat_id => seat.id}
      expect(response).to redirect_to :back
    end
  end
  end
end
