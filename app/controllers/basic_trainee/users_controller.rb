class BasicTrainee::UsersController < BasicTrainee::BasicApplicationController
  layout :resolve_layout
  before_action :load_user, only: :show_profile
  before_action :load_user_courses, only: :index

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.user.signup_succ"
      redirect_to login_path
    else
      flash[:danger] = t "flash.user.signup_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def show_profile
    respond_to :js
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :address,
      :password_confirmation, :phone_number
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_users_path
  end

  def resolve_layout
    case action_name
    when :new, :create
      "process_account"
    else
      "basic_application"
    end
  end
end
