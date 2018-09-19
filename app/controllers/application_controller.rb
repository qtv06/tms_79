class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user!
    return if current_user.present?
    flash[:danger] = t "form.require_login"
    redirect_to login_path
  end

  def authenticate_suppervisor!
    return if current_user.suppervisor?
    flash[:danger] = t "form.cant_access"
    redirect_to login_path
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
end
