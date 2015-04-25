class Admin::TicketTypesController < Admin::BaseController
  before_action :set_ticket_type, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy]

  # GET /ticket_types
  # GET /ticket_types.json
  def index
    @ticket_types = TicketType.all.order(is_seat: :asc, name: :asc)
  end

  # GET /ticket_types/1
  # GET /ticket_types/1.json
  def show
    @tickets = Ticket.where(:ticket_type => @ticket_type) unless @ticket_type.is_seat
    @seats = Seat.joins(:ticket).where("tickets.ticket_type_id = " + @ticket_type.id.to_s) if @ticket_type.is_seat
  end

  # GET /ticket_types/new
  def new
    @ticket_type = TicketType.new
  end

  # GET /ticket_types/1/edit
  def edit
  end

  # POST /ticket_types
  # POST /ticket_types.json
  def create
    @ticket_type = TicketType.new(ticket_type_params)

    respond_to do |format|
      if @ticket_type.save
        format.html { redirect_to admin_ticket_type_path(@ticket_type), notice: 'Ticket type was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_type }
      else
        format.html { render :new }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_types/1
  # PATCH/PUT /ticket_types/1.json
  def update
    respond_to do |format|
      if @ticket_type.update(ticket_type_params)
        format.html { redirect_to admin_ticket_type_path(@ticket_type), notice: 'Ticket type was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_type }
      else
        format.html { render :edit }
        format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_types/1
  # DELETE /ticket_types/1.json
  def destroy
    @ticket_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_ticket_types_url, notice: 'Ticket type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_type
      @ticket_type = TicketType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_type_params
      params.require(:ticket_type).permit(:name, :description, :price, :is_seat)
    end
end
