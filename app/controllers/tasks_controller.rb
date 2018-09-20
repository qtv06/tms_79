class TasksController < ApplicationController
  before_action :load_subject
  before_action :load_task, only: %i(destroy edit update)

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

  def edit; end

  def update
    if @task.update task_params
      load_tasks
      respond_to :js
    else
      flash[:danger] = t "flash.fail"
      redirect_to subject_path(@subject)
    end
  end

  def destroy
    if @task.destroy
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

  def load_task
    @task = Task.find_by id: params[:id]
    return if @task
    flash[:danger] = t "flash.not_found"
    redirect_to subject_path(@subject)
  end
end
