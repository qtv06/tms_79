module ApplicationHelper
  def default_img obj_img, img_default
    obj_img.blank? ? img_default : obj_img.url
  end

  def authenticate_user!
    redirect_to login_path if current_user.blank?
  end

  def format_date datetime
    datetime.strftime I18n.t("string_format_time")
  end
end
