class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy, :destroy_multiple]


  # GET /orders
  # GET /orders.json
  def index
    @orders = Reservation.all.order(created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @seats = Seat.all.joins(:ticket).where('tickets.reservation_id = ' + @order.id.to_s)
    @tickets = Ticket.where(reservation: @order, seat: nil)
  end

  # GET /orders/1/edit
  def edit
    @seats = Seat.all.joins(:ticket).where('tickets.reservation_id = ' + @order.id.to_s)
    @tickets = Ticket.where(reservation: @order, seat: nil)
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

  def destroy_multiple
    @orders = Reservation.find(params[:order_ids])

    @orders.each do |order|
      order.delete
    end

    redirect_to admin_orders_path, notice: "Orders deleted."
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to admin_orders_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:paid)
    end
end
