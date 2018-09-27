class SubjectsController < ApplicationController
  before_action :find_subject, only: %i(show edit update)
  before_action :load_tasks, only: :show

  def index
    @subjects = Subject.newest.page params[:page]
  end

  def show; end

  def new
    @subject = Subject.new
    @subject.tasks.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      redirect_to subjects_path
    else
      render :new
    end
  end

  def edit
    @subject.tasks.new
  end

  def update
    debugger
    if @subject.update subject_params
      redirect_to subjects_path
    else
      render :edit
    end
  end

  private

  def find_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?
    flash[:danger] = t "flash.not_found"
    redirect_to subjects_path
  end

  def subject_params
    params.require(:subject).permit Subject::ATTRIBUTES
  end
end
