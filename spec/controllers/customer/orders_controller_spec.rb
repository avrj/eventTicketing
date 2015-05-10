require 'rails_helper'

RSpec.describe Customer::OrdersController, type: :controller do
  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      customer = FactoryGirl.create(:customer)
      session[:customer_user_id] = customer.id

      get :index

      expect(response).to render_template("index")
    end
  end

#  describe "GET show" do
#    it "responds successfully with an HTTP 200 status code" do
#      customer = FactoryGirl.create(:customer)
#      session[:customer_user_id] = customer.id

#      get :show

#      expect(response).to be_success
#      expect(response).to have_http_status(200)
#    end

#    it "renders the index template" do
#      customer = FactoryGirl.create(:customer)
#      session[:customer_user_id] = customer.id

#      get :show

#      expect(response).to render_template :show
#    end
#  end

  describe 'POST pay' do
    context 'with an unpaid reservation' do
      it 'changes the reservation status to paid' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        reservation = FactoryGirl.create(:reservation, customer: customer)

        post :pay, {:order_id => reservation.id}
        expect(Reservation.last.paid).to be(true)
      end

      it 'redirects to back' do
        customer = FactoryGirl.create(:customer)
        session[:customer_user_id] = customer.id

        reservation = FactoryGirl.create(:reservation, customer: customer)

        post :pay, {:order_id => reservation.id}
        expect(response).to redirect_to customer_order_path(reservation)
      end
    end
  end

#  describe 'POST create' do
#    context 'with valid attributes' do
#      it 'creates the order' do
#        ticket_type_seat = FactoryGirl.create(:ticket_type_seat)
#        ticket_type = FactoryGirl.create(:ticket_type)
#         ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)
#         seat = FactoryGirl.create(:seat)
#         ticket_seat = FactoryGirl.create(:ticket, ticket_type: ticket_type_seat, seat: seat, code: "XXXXXXXX")
#
#         session[:tickets] = [ticket_type.id.to_s => "1"]
#         session[:seats] = [seat.id]
#
#         customer = FactoryGirl.create(:customer)
#         session[:customer_user_id] = customer.id
#
#         post :create, reservation: FactoryGirl.attributes_for(:reservation)
#         expect(Reservation.count).to eq(1)
#       end
#
#       it 'redirects to the "show" action for the new order' do
#         customer = FactoryGirl.create(:customer)
#         session[:customer_user_id] = customer.id
#
#         post :create, reservation: FactoryGirl.attributes_for(:reservation)
#         expect(response).to redirect_to customer_order_path(Reservation.last)
#       end
#     end
#     end
end
