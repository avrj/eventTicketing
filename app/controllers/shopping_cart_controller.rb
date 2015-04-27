class ShoppingCartController < ApplicationController
  def index
    @seats = Seat.where(:id => session[:seats]).joins(:ticket).where('tickets.reservation_id is null').order(table: :asc, seat: :asc)
    @shopping_cart_total_price = 0

    @seats.each do |seat|
      @shopping_cart_total_price += seat.ticket.ticket_type.price
    end

    @tickets = session[:tickets]

    @tickets.each { |ticket_type_id, quantity| @shopping_cart_total_price += TicketType.find(ticket_type_id).price.to_i * quantity.to_i } unless @tickets.nil?

    @ticket_types = TicketType.where(:id => @tickets.keys, :is_seat => false) unless @tickets.nil?

    if @tickets or @seats.size > 0
      session[:shopping_cart_current_step] = "shopping_cart"
    else
      session.delete(:shopping_cart_current_step)
    end
  end

  def add_tickets
    if params.has_key?(:tickets)
      count = 0;

      params[:tickets].each do |ticket, quantity|
        if quantity.to_i > 0
          count += quantity.to_i
        else
          params[:tickets].delete ticket
          end
      end

      if count > 0
        session[:tickets] = params[:tickets]
        redirect_to shopping_cart_path
      else
        session[:tickets] = nil
        redirect_to :back
      end
    else

      redirect_to :back
    end
  end

  def add_seats
      if params.has_key?(:seats)
        session[:seats] = params[:seats]
        redirect_to shopping_cart_path
      else
        redirect_to :back
        end
  end

  def delete_seat
    session[:seats].delete(params[:id])

    redirect_to shopping_cart_path
  end

  def update_qty
    params[:id]
    raise
  end

  def destroy
    session.delete(:seats)
    session.delete(:tickets)

    redirect_to shopping_cart_path
  end

  def checkout
    redirect_to login_or_register_path, alert:'you should be signed in' and return if current_customer_user.nil?

    if session[:shopping_cart_current_step] != "shopping_cart"
      redirect_to shopping_cart_path and return
    end

    @seats = Seat.where(:id => session[:seats]).joins(:ticket).where('tickets.reservation_id is null').order(table: :asc, seat: :asc)
    @shopping_cart_total_price = 0

    @seats.each do |seat|
      @shopping_cart_total_price += seat.ticket.ticket_type.price
    end

    @tickets = session[:tickets]

    @tickets.each { |ticket_type_id, quantity| @shopping_cart_total_price += TicketType.find(ticket_type_id).price.to_i * quantity.to_i } unless @tickets.nil?

    @ticket_types = TicketType.where(:id => @tickets.keys) unless @tickets.nil?
  end

  def login_or_register
    @customer = Customer.new
  end
end