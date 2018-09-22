class BasicTrainee::CoursesController < BasicTrainee::BasicApplicationController
  before_action :authenticate_user!
  before_action :load_course, :load_trainees, :load_suppervisors, :load_subjects
  before_action :load_user_subject, :load_task_of_subject

  def show
    gon.subjects = @subjects
  end

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

  def load_task_of_subject
    @user_subjects_tasks = []
    @user_subjects.each do |user_subject|
      task_ids = Task.ids_of_subject(user_subject.subject_id)

      user_subject_tasks = UserTask.of_user_in_subject(current_user.id,
        task_ids).includes(:task)

      object = {}
      object["subject"] = user_subject.subject
      object["task_status_finish"] = user_subject_tasks.finish.size
      object["user_subject_tasks"] = user_subject_tasks.size
      @user_subjects_tasks << object
    end
  end
end
