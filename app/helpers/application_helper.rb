module ApplicationHelper
  def format_date datetime
    datetime.strftime I18n.t("string_format_time")
  end

  def show_profile_path user
    return show_profile_user_path(user) if current_user.suppervisor?
    show_profile_basic_trainee_user_path(user)
  end

  def subject_detail_path subject, course
    return subject_path(subject) if current_user.suppervisor?
    basic_trainee_course_subject_path(course, subject)
  end

  def course_detail_path course
    return course_path(course) if current_user.suppervisor?
    basic_trainee_course_path(course)
  end

  def color_status user_task
    if user_task.open?
      Settings.css_class.primary
    elsif user_task.doing?
      Settings.css_class.danger
    else
      Settings.css_class.success
    end
  end

  def is_active? course
    course.user_courses.active.present?
  end

  def percent_process finished, sum
    result = sum.zero? ? 0 : (finished / sum.to_f * 100).to_i
    result.to_s + Settings.percent_char
  end
end
