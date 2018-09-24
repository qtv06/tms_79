class BasicTrainee::UsersController < BasicTrainee::BasicApplicationController
  layout :resolve_layout
  before_action :authenticate_user!, except: %i(new create)
  before_action :load_user, only: :show_profile
  before_action :load_user_courses, only: :index

  def index; end

  def show; end

  def edit; end

  def show_profile
    respond_to :js
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_users_path
  end

  def resolve_layout
    case action_name
    when "new", "create"
      "process_account"
    else
      "basic_application"
    end
  end
end
