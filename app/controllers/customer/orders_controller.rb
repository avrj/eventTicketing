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

  # GET /orders/new
  def new
    @order = Reservation.new
    @ticket_types = TicketType.all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    konepaikat = order_params[:tickets]

    @order = Reservation.new(order_params_without_tickets)
    @order.customer = current_customer_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
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
