class SubjectsController < ApplicationController
  def index
    @subjects = Subject.newest.page params[:page]
  end
end
