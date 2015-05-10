class Customer::SessionsController < ApplicationController
  before_action :ensure_that_customer_is_not_signed_in, only: [:new, :create]

  def new
    # renderöi kirjautumissivun
    @customer = Customer.new
  end

  def create
    customerUser = Customer.find_by email: customer_params[:email]

    if customerUser && customerUser.authenticate(customer_params[:password])
      session[:customer_user_id] = customerUser.id
      if customer_params[:redirect] == "checkout"
        redirect_to shopping_cart_checkout_path
      else
        redirect_to customer_orders_path, notice: "Welcome back!"
      end
    else
      alert = "Username and/or password mismatch"
      redirect_to :back, alert: alert
    end
  end

  def destroy
    # nollataan sessio
    session[:customer_user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:email, :password, :redirect)
  end
end
