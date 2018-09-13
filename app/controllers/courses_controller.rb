class CoursesController < ApplicationController
  before_action :find_course, except: %i(index new create)
  before_action :load_subjects, :load_trainees, :load_suppervisors, only: :show

  def index
    @courses = Course.all.order_desc.page params[:page]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "flash.course.new_succ", course_name: @course.name
      redirect_to courses_path
    else
      flash[:fail] = t "flash.course.fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @course.update course_params
      flash[:success] = t "flash.course.update_succ", course_name: @course.name
      redirect_to courses_path
    else
      flash[:danger] = t "flash.course.fail"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "flash.course.delete_succ", course_name: @course.name
    else
      flash[:danger] = t "flash.course.delete_fail"
    end
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit :name, :description, :time_training, :cover
  end

  def find_course
    @course = Course.find_by id: params[:id]
    return @course if @course.present?
    flash[:danger] = t "flash.not_found"
    redirect_to courses_path
  end
end
