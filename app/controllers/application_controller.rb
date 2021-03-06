class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_admin_user
  helper_method :current_customer_user
  helper_method :shopping_cart_count
  helper_method :slack_msg
  helper_method :shopping_cart

  def shopping_cart_count
    count = 0
    if session[:seats].present?
      count += session[:seats].length
    end

    if session[:tickets].present?
      session[:tickets].each do |ticket, quantity|
        count += quantity.to_i
      end
    end

    return count
  end

  def current_admin_user
    return nil if session[:admin_user_id].nil?
    Admin.find(session[:admin_user_id])
  end

  def current_customer_user
    return nil if session[:customer_user_id].nil?
    Customer.find(session[:customer_user_id])
  end


  def ensure_that_admin_is_signed_in
    redirect_to admin_login_path, alert:'you should be signed in' if current_admin_user.nil?
  end

  def ensure_that_customer_is_signed_in
    redirect_to customer_login_path, alert:'you should be signed in' if current_customer_user.nil?
  end

  def ensure_that_customer_is_not_signed_in
    redirect_to customer_orders_path if current_customer_user
  end

  def ensure_that_admin_is_superuser
    redirect_to :back, alert:'You don\'t have enough privileges to do that.' unless current_admin_user.superuser
  end


  def slack_msg(message)
    require 'slack-notifier'

    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", channel: '#web',
                                   username: 'lippukauppa'

    notifier.ping message
  end

  def shopping_cart
    @shopping_cart ||= ShoppingCart.new(session)
  end
end
