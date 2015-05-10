class Admin::SeatsController < Admin::BaseController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy, :destroy_multiple]

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
    @ticket_types = TicketType.where(:is_seat => true)
  end

  # GET /seats/1/edit
  def edit
    @ticket_types = TicketType.where(:is_seat => true)
    @seat.code = Ticket.find_by(seat: @seat).code
    @seat.given_away = Ticket.find_by(seat: @seat).given_away
    @seat.ticket_type = Ticket.find_by(seat: @seat).ticket_type_id
  end

  # POST /seats
  # POST /seats.json
  def create
    @seat = Seat.new(seat_params)

    random_digits = rand(9999999999).to_s.center(10, rand(9).to_s)

    unless Ticket.find_by(:code => random_digits).nil?
      random_digits = rand(9999999999).to_s.center(10, rand(9).to_s)
    end

    @ticket = Ticket.new(seat: @seat, code: random_digits, given_away: seat_params[:given_away], ticket_type_id: seat_params[:ticket_type])

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

  def toggle_given_away
    @seat = Seat.find(params[:seat_id])

    @ticket = Ticket.find_by(seat: @seat)

    if @ticket.given_away
      @ticket.update_attribute(:given_away, false)
      redirect_to :back, notice: "Seat is now marked as not given away."
    else
      @ticket.update_attribute(:given_away, true)
      redirect_to :back, notice: "Seat is now marked as given away."
    end
  end

  # PATCH/PUT /seats/1
  # PATCH/PUT /seats/1.json
  def update
    errors = false
    respond_to do |format|
      if @seat.update(seat_params)
        @ticket = Ticket.find_by(seat: @seat)
        if @ticket.update(code: seat_params[:code], given_away: seat_params[:given_away], ticket_type_id: seat_params[:ticket_type])
          format.html { redirect_to admin_seat_path(@seat), notice: 'Seat was successfully updated.' }
          format.json { render :show, status: :ok, location: @seat }
        else
          errors = true
        end
      else
        errors = true
      end

      if errors
        format.html { render :edit }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_multiple
    @seats = Seat.find(params[:seat_ids])

    @seats.each do |seat|
      ticket = Ticket.find_by(seat: seat)
      ticket.destroy
      seat.destroy
    end

    redirect_to admin_seats_path, notice: "Seats deleted."
  end

  # DELETE /seats/1
  # DELETE /seats/1.json
  def destroy
    @ticket = Ticket.find_by(seat: @seat)
    @ticket.destroy
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
