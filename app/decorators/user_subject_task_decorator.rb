class UserSubjectTaskDecorator < Draper::Decorator
  delegate_all

  def color_status
    if object.open?
      Settings.css_class.primary
    elsif object.doing?
      Settings.css_class.danger
    else
      Settings.css_class.success
    end
  end
end
