class ShoppingCartController < ApplicationController
  def index
    if shopping_cart.tickets or shopping_cart.seats.count > 0
      session[:shopping_cart_current_step] = "shopping_cart"
    else
      session.delete(:shopping_cart_current_step)
    end
  end

  def add_tickets
    if params.has_key?(:tickets)
      count = 0;

      params[:tickets].each do |ticket, quantity|
        if quantity.to_i > 0
          count += quantity.to_i
        else
          params[:tickets].delete ticket
          end
      end

      if count > 0
        shopping_cart.merge_tickets(params[:tickets])
        redirect_to shopping_cart_path
      else
        shopping_cart.delete_tickets
        redirect_to :back
      end
    else

      redirect_to :back
    end
  end

  def add_seats
      if params.has_key?(:seats)
        shopping_cart.merge_seats params[:seats]
        redirect_to shopping_cart_path
      else
        redirect_to :back
        end
  end

  def delete_seat
    shopping_cart.delete_seat params[:id]

    redirect_to shopping_cart_path
  end

  def update_qty
    params[:id]
    raise
  end

  def destroy
   shopping_cart.empty

    redirect_to shopping_cart_path
  end

  def checkout
    redirect_to login_or_register_path, alert:'you should be signed in' and return if current_customer_user.nil?

    if session[:shopping_cart_current_step] != "shopping_cart"
      redirect_to shopping_cart_path and return
    end
  end

  def login_or_register
    @customer = Customer.new
  end
end