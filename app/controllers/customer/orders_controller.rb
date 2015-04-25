class Customer::OrdersController < Customer::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_customer_is_signed_in


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
