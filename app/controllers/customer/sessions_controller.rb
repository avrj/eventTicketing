class Customer::SessionsController < ApplicationController
  before_action :ensure_that_customer_is_not_signed_in, only: [:new, :create]

  def new
    # renderöi kirjautumissivun
  end

  def create
    customerUser = Customer.find_by email: params[:email]

    if customerUser && customerUser.authenticate(params[:password])
      session[:customer_user_id] = customerUser.id
      redirect_to customer_root_path, notice: "Welcome back!"
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
end