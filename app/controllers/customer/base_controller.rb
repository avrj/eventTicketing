class Customer::BaseController < ApplicationController
  before_action :ensure_that_customer_is_signed_in
end