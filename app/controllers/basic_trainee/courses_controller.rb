class BasicTrainee::CoursesController < BasicTrainee::BasicApplicationController
  before_action :authenticate_user!
  before_action :load_course, only: :show
  before_action :load_subjects, :load_trainees, :load_suppervisors, only: :show

  def show; end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_users_path
  end
end
