class UsersController < ApplicationController
  before_action :authenticate_user!, :authenticate_suppervisor!
  before_action :find_user, except: %i(index new create)

  def index
    @suppervisors = User.suppervisor.newest
    @trainees = User.trainee.newest
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.user.add_succ", user_name: @user.name
      redirect_to users_path
    else
      flash[:danger] = t "flash.user.fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "flash.user.update_succ", user_name: @user.name
      redirect_to users_path
    else
      flash[:danger] = t "flash.user.fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.user.delete_succ", user_name: @user.name
    else
      flash[:danger] = t "flash.user.fail"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :address,
      :password_confirmation, :phone_number, :role, :avatar
  end

  def find_user
    @user = User.find_by id: params[:id]
    return @user if @user.present?
    flash[:danger] = t "flash.not_found"
    redirect_to users_path
  end

  def show_profile
    @user = User.find_by id: params[:id]
    if @user.present?
      respond_to :js
    else
      flash[:danger] = t "flash.not_found"
      redirect_to root_path
    end
  end
end
