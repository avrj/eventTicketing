class Customer::OrdersController < Customer::BaseController
  before_action :ensure_that_customer_is_signed_in
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def create
    @tickets = session[:tickets]
    @seats = session[:seats]

    @real_seats = Seat.where(:id => @seats).joins(:ticket).where("tickets.reservation_id is null AND tickets.given_away = 'f'")

    @order = Reservation.new
    @order.customer = current_customer_user
    @order.paid = params[:is_paid]
    @order.save

    tickets_count = 0

    shopping_cart_total_price = 0

    if @tickets
      @tickets.each do |ticket_type_id, quantity|
        tickets_count += quantity.to_i

        shopping_cart_total_price += TicketType.find(ticket_type_id).price.to_i * quantity.to_i

        quantity.to_i.times do |n|
          Ticket.where(ticket_type_id: ticket_type_id, reservation: nil, given_away: false).limit(1).update_all(:reservation_id => @order.id)
        end
      end
    end

    @real_seats.each do |real_seat|
      real_seat.ticket.update_attribute(:reservation_id, @order.id)
      shopping_cart_total_price += real_seat.ticket.ticket_type.price
    end

    if @seats
      if @tickets
        slack_msg("#{current_customer_user.firstname} #{current_customer_user.lastname} bought  #{ActionController::Base.helpers.pluralize(tickets_count, "ticket")} and #{ActionController::Base.helpers.pluralize(@seats.count, "seat")} (total of #{ActionController::Base.helpers.number_to_currency(shopping_cart_total_price)})")
      else
        slack_msg("#{current_customer_user.firstname} #{current_customer_user.lastname} bought #{ActionController::Base.helpers.pluralize(@seats.count, "seat")}  (total of #{ActionController::Base.helpers.number_to_currency(shopping_cart_total_price)})")
      end
    else
      if @tickets
        slack_msg("#{current_customer_user.firstname} #{current_customer_user.lastname} bought  #{ActionController::Base.helpers.pluralize(tickets_count, "ticket")}  (total of #{ActionController::Base.helpers.number_to_currency(shopping_cart_total_price)})")
      end
    end

    session.delete(:seats)
    session.delete(:tickets)

    redirect_to customer_order_path(@order), notice: 'Order completed.'
  end

  def pay
    @order = Reservation.find(params[:order_id])

    redirect_to customer_order_path(@order) if @order.customer != current_customer_user

    if @order.paid
      redirect_to customer_order_path(@order), notice: 'You have already paid your order.'
    else
      @order.update_attribute(:paid, true)
      redirect_to customer_order_path(@order), notice: 'Your order is now marked as paid.'
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Reservation.where(customer: current_customer_user).order(created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    redirect_to customer_orders_path if @order.customer != current_customer_user

    @seats = Seat.all.joins(:ticket).where('tickets.reservation_id = ' + @order.id.to_s)
    @tickets = Ticket.where(reservation: @order, seat: nil)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Reservation.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params_without_tickets
    params.require(:order).permit(:paid)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:paid, :tickets => [:"Normaali konepaikka", :"VIP-konepaikka", :"Kävijälippu"])
    end
end
