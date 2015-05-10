class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy, :destroy_multiple]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.where(:ticket_type => TicketType.where(:is_seat => false))
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticket_types = TicketType.where(:is_seat => false)
  end

  # GET /tickets/1/edit
  def edit
    @ticket_types = TicketType.where(:is_seat => false)
  end

  # POST /tickets
  # POST /tickets.json
  def create
    errors = false

    for counter in 1..ticket_params[:quantity].to_i
      @ticket = Ticket.new(ticket_params)

      random_digits = rand(9999999999).to_s.center(10, rand(9).to_s)

      unless Ticket.find_by(:code => random_digits).nil?
        random_digits = rand(9999999999).to_s.center(10, rand(9).to_s)
      end

      @ticket.code = random_digits

      if !@ticket.save
        errors = true
      end
    end

    respond_to do |format|
      if errors
          format.html { render :new }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to admin_tickets_path, notice: "Ticket(s) was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      end

    end
  end

  def toggle_given_away
    @ticket = Ticket.find(params[:ticket_id])

    if @ticket.given_away
      @ticket.update_attribute(:given_away, false)
      redirect_to :back, notice: "Seat is now marked as not given away."
    else
      @ticket.update_attribute(:given_away, true)
      redirect_to :back, notice: "Seat is now marked as given away."
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to admin_ticket_path(@ticket), notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_multiple
    @tickets = Ticket.find(params[:ticket_ids])

    @tickets.each do |ticket|
      ticket.delete
    end

    redirect_to admin_tickets_path, notice: "Tickets deleted."
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to admin_tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:code, :given_away, :ticket_type_id, :quantity)
    end
end
