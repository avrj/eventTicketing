class CustomersController < ApplicationController
  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        session[:customer_user_id] = @customer.id
        if params[:redirect] == "checkout"
          format.html { redirect_to shopping_cart_checkout_path, notice: 'Customer was successfully created.' }
        else
          format.html { redirect_to shopping_cart_path, notice: 'Customer was successfully created.' }
        end
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:email, :password, :password_confirmation, :firstname, :lastname, :address, :postcode, :city, :phone, :age, :gender)
    end
end
