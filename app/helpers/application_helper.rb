module ApplicationHelper
  def authenticate_user!
    redirect_to login_path if current_user.blank?
  end

  def format_date datetime
    datetime.strftime I18n.t("string_format_time")
  end
end
