class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_is_superuser, only: [:create, :edit, :update, :destroy, :destroy_multiple]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @seats = @customer.seats
    @tickets = @customer.tickets
    @orders = @customer.reservations
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
    if customer_params[:password].empty? && customer_params[:password_confirmation].empty?
      if @customer.update(customer_params_without_new_password)
        redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.'
      else
        render :edit
      end
    else
      if @customer.update(customer_params_with_new_password)
        redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    @customers = Customer.find(params[:customer_ids])

    @customers.each do |customer|
      customer.delete
    end

    redirect_to admin_customers_path, notice: "Customers deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

  def customer_params_without_new_password
    params.require(:customer).permit(:email, :firstname, :lastname, :address, :postcode, :city, :phone, :date_of_birth, :gender)
  end

  def customer_params_with_new_password
    params.require(:customer).permit(:email, :password, :password_confirmation, :firstname, :lastname, :address, :postcode, :city, :phone, :date_of_birth, :gender)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :address, :postcode, :city, :phone, :date_of_birth, :gender)
  end
end
