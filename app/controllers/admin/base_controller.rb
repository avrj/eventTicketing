class Admin::BaseController < ApplicationController
  before_action :ensure_that_admin_is_signed_in

  layout 'admin/application'
end