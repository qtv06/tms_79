class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user!
    return if current_user.present?
    flash[:danger] = t "form.require_login"
    redirect_to login_path
  end

  def authenticate_suppervisor!
    return if current_user.is_suppervisor?
    flash[:danger] = t "form.cant_access"
    redirect_to login_path
  end
end
