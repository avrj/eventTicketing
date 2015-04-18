class Admin::SessionsController < ApplicationController
  layout 'login'

  def new
    # renderöi kirjautumissivun
  end

  def create
    adminUser = Admin.find_by username: params[:username]
    if adminUser && adminUser.authenticate(params[:password])
      session[:admin_user_id] = adminUser.id
      redirect_to admin_orders_path, notice: "Welcome back!"
    else
      alert = "Username and/or password mismatch"
      redirect_to :back, alert: alert
    end
  end

  def destroy
    # nollataan sessio
    session[:admin_user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
