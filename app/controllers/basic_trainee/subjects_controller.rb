class BasicTrainee::SubjectsController <
  BasicTrainee::BasicApplicationController
  before_action :authenticate_user!
  before_action :load_course, :load_user_subject, :load_task_ids
  before_action :load_user_tasks_of_subject, only: %i(show finish_subject)
  before_action :load_user_task, except: %i(show finish_subject)

  def show
    subject_id = @user_subject.subject_id
    task_ids = Task.where(subject_id: subject_id).pluck :id
    user_ids = UserSubject.where(subject_id: subject_id).pluck :user_id
    # binding.pry
    @statistic_user_task = User.statistical(task_ids, user_ids).map{|u| [u.name, u.count]}.to_h
  end

  def start_task
    @user_task.update_time_status_to_start_user_task
    load_user_tasks_of_subject
    respond_to :js
  end

  def finish_task
    @user_task.update_time_status_to_finish_user_task
    load_user_tasks_of_subject
    if @user_subject_tasks.finish.size == @user_subject_tasks.size
      UserSubject.transaction do
        @user_subject.update_status_to_finish
      end
    end
    respond_to :js
  end

  def finish_subject
    begin
      UserSubject.transaction do
        @user_subject.update_status_to_finish
        UserTask.transaction do
          @user_subject_tasks.update_all(status: :finish)
        end
      end
      flash[:success] = t "flash.subject.finished",
        name: @user_subject.subject_name
    rescue
      flash[:danger] = t "flash.fail"
    end

    redirect_to basic_trainee_course_subject_path(@course, @user_subject)
  end

  private

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    return if @user_subject
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
    @task_ids = Task.ids_of_subject(@user_subject.subject_id)
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
    redirect_to basic_trainee_course_subject(@course, @user_subject.subject)
  end
end
