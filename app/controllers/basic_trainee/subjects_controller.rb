class BasicTrainee::SubjectsController <
  BasicTrainee::BasicApplicationController
  before_action :load_course, :load_subject, :load_task_ids,
    :load_user_tasks_of_subject

  def show; end

  private

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "flash.not_found"
    redirect_to course_path(@course)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_users_path
  end

  def load_task_ids
    @task_ids = Task.ids_of_subject(@subject.id)
  end

  def load_user_tasks_of_subject
    @user_subject_tasks =
      if @task_ids
        UserTask.of_user_in_subject(current_user.id, @task_ids).includes(:task)
      else
        nil
      end
  end
end
