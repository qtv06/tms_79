class SessionsController < ApplicationController
  layout "process_account"
  include SessionsHelper

  def new; end

  def create
    user = User.find_by email: params[:session][:email]
    if user&.authenticate(params[:session][:password])
      login user
      flash[:success] = t "flash.user.login_succ"
      url = user.suppervisor? ? root_path : basic_trainee_users_path

      redirect_to url
    else
      flash[:danger] = t "flash.user.login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
