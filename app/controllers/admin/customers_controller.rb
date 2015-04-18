class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :tickets, :orders, :seats]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  def tickets
    @tickets = @customer.tickets
  end

  def orders
    @orders = @customer.reservations
  end

  def seats
    @seats = @customer.seats
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit

  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to admin_customer_path(@customer), notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
      if @customer.authenticate(customer_params[:current_password])
          respond_to do |format|
            if @customer.update(customer_edit_params)
              format.html { redirect_to admin_customer_path(@customer)g, notice: 'Customer was successfully updated.' }
              format.json { render :show, status: :ok, location: @customer }
            else
              format.html { render :edit }
              format.json { render json: @customer.errors, status: :unprocessable_entity }
            end
          end
      else
        redirect_to :back, alert: 'Wrong password.'
      end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

  def customer_edit_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :firstname, :lastname, :address, :postcode, :city, :phone, :age, :gender)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :address, :postcode, :city, :phone, :age, :gender)
    end
end
