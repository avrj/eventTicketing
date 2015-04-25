class Customer::ContactInformationsController < Customer::BaseController
  before_action :set_customer

  def show

  end

  def edit

  end

  def update
    if @customer.authenticate(customer_params[:current_password])
        if customer_params[:password].empty? && customer_params[:password_confirmation].empty?
          if @customer.update(customer_params_without_new_password)
            redirect_to customer_contact_information_path, notice: 'Customer was successfully updated.'
          else
            render :edit
          end
        else
          if @customer.update(customer_params_with_new_password)
            redirect_to customer_contact_information_path, notice: 'Customer was successfully updated.'
          else
            render :edit
          end
        end
    else
      redirect_to :back, alert: 'Wrong password.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = current_customer_user
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