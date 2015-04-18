class OrdersController < ApplicationController
  before_action :ensure_that_customer_is_signed_in

  def create
    @tickets = session[:tickets]
    @seats = session[:seats]

    @real_seats = Seat.where(:id => @seats).joins(:ticket).where('tickets.reservation_id is null')

    @order = Reservation.new
    @order.customer = current_customer_user
    @order.paid = params[:is_paid]
    @order.save

    if @tickets
      @tickets.each do |ticket_type_id, quantity|
        quantity.to_i.times do |n|
          Ticket.where(ticket_type_id: ticket_type_id, reservation: nil).limit(1).update_all(:reservation_id => @order.id)
        end
      end
    end

    @real_seats.each do |real_seat|
      real_seat.ticket.update_attribute(:reservation_id, @order.id)
    end

    session.delete(:seats)
    session.delete(:tickets)

    redirect_to customer_order_path(@order), notice: 'Order completed.'
  end

end