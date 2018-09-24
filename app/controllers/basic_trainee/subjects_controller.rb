class BasicTrainee::SubjectsController <
  BasicTrainee::BasicApplicationController
  before_action :authenticate_user!
  before_action :load_course, :load_subject, :load_task_ids
  before_action :load_user_tasks_of_subject, only: :show
  before_action :load_user_task, except: :show

  def show; end

  def start_task
    @user_task.update_time_status_to_start_user_task
    load_user_tasks_of_subject
    respond_to :js
  end

  def finish_task
    @user_task.update_time_status_to_finish_user_task
    load_user_tasks_of_subject
    respond_to :js
  end

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
      end
  end

  def load_user_task
    @user_task = UserTask.find_by id: params[:user_task]
    return if @user_task
    flash[:danger] = t "flash.not_found"
    redirect_to basic_trainee_course_subject(@course, @subject)
  end
end
