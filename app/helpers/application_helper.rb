module ApplicationHelper
  def authenticate_user!
    redirect_to login_path if current_user.blank?
  end

  def format_date datetime
    datetime.strftime I18n.t("string_format_time")
  end

  def show_profile_path user
    return show_profile_user_path(user) if current_user.suppervisor?
    show_profile_basic_trainee_user_path(user)
  end
end
