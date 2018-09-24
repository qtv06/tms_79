class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, if: :devise_controller?

  def authenticate_suppervisor!
    return if current_user.suppervisor?
    flash[:danger] = t "form.cant_access"
    redirect_to user_session_path
  end

  def load_subjects
    @subjects = @course.subjects
  end

  def load_trainees
    @trainees = UserCourse.user_on_course_with_a_role @course.id,
      User.trainee
  end

  def load_suppervisors
    @suppervisors = UserCourse.user_on_course_with_a_role @course.id,
      User.suppervisor
  end

  def load_user_courses
    @user ||= current_user
    @user_courses = @user.user_courses.includes(:course)
  end

  def load_tasks
    @tasks = @subject.tasks.newest
  end

  private

  def after_sign_in_path_for resource
    return root_path if resource.suppervisor?
    basic_trainee_root_path
  end

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User::USER_PARAMS)
  end
end
