class Admin::SeatsController < Admin::BaseController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy]

  # GET /seats
  # GET /seats.json
  def index
    @seats = Seat.all.order(table: :asc, seat: :asc)
  end

  # GET /seats/1
  # GET /seats/1.json
  def show
  end

  # GET /seats/new
  def new
    @seat = Seat.new
    @ticket_types = TicketType.where("is_seat IS NOT NULL")
  end

  # GET /seats/1/edit
  def edit
    @ticket_types = TicketType.where("is_seat IS NOT NULL")
    @seat.code = Ticket.find_by(seat: @seat).code
    @seat.given_away = Ticket.find_by(seat: @seat).given_away
    @seat.ticket_type = Ticket.find_by(seat: @seat).ticket_type_id
  end

  # POST /seats
  # POST /seats.json
  def create
    @seat = Seat.new(seat_params)
    @ticket = Ticket.new(seat: @seat, code: seat_params[:code], given_away: seat_params[:given_away], ticket_type_id: seat_params[:ticket_type])

    respond_to do |format|
        if @seat.valid? && @ticket.valid?
          @seat.save
             @ticket.save
            format.html { redirect_to admin_seat_path(@seat), notice: 'Seat was successfully created.' }
            format.json { render :show, status: :created, location: @seat }
          else
            format.html { render :new }
            format.json { render json: @seat.errors, status: :unprocessable_entity }
          end
    end
  end

  # PATCH/PUT /seats/1
  # PATCH/PUT /seats/1.json
  def update
    respond_to do |format|
      if @seat.update(seat_params)
        @ticket = Ticket.find_by(seat: @seat)
        if @ticket.update(code: seat_params[:code], given_away: seat_params[:given_away], ticket_type_id: seat_params[:ticket_type])
          format.html { redirect_to admin_seat_path(@seat), notice: 'Seat was successfully updated.' }
          format.json { render :show, status: :ok, location: @seat }
        else
          format.html { render :edit }
          format.json { render json: @seat.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seats/1
  # DELETE /seats/1.json
  def destroy
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to admin_seats_url, notice: 'Seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat
      @seat = Seat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seat_params
      params.require(:seat).permit(:table, :seat, :x, :y, :angle, :code, :given_away, :ticket_type)
    end
end
