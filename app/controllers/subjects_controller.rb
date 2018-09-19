class SubjectsController < ApplicationController
  before_action :find_subject, only: :show
  before_action :load_tasks, only: :show

  def index
    @subjects = Subject.newest.page params[:page]
  end

  def show; end

  private

  def find_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?
    flash[:danger] = t "flash.not_found"
    redirect_to subjects_path
  end
end
