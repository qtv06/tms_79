class TasksController < ApplicationController
  before_action :load_subject, only: :create

  def create
    @task = @subject.tasks.build task_params
    if @task.save
      load_tasks
      respond_to :js
    else
      flash[:danger] = t "flash.fail"
      redirect_to subject_path(@subject)
    end
  end

  private

  def task_params
    params.require(:task).permit :name, :description
  end

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
    return if @subject
    flash[:danger] = t "subject.not_found"
    redirect_to subjects_path
  end
end
