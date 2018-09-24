class BasicTrainee::CoursesController < BasicTrainee::BasicApplicationController
  before_action :authenticate_user!
  before_action :load_course, :load_trainees, :load_suppervisors
  before_action :load_user_subject

  def show; end

  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_users_path
  end

  def load_user_subject
    @user_subjects = UserSubject.of_user_in_course(current_user.id,
      @course.id).includes(:subject)
  end
end
