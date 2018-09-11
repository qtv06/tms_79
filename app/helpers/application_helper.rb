module ApplicationHelper
  def default_avatar user
    user.avatar.blank? ? Settings.user.avatar_default : user.avatar
  end

  def authenticate_user!
    redirect_to login_path if current_user.blank?
  end
end
