class CoursesController < ApplicationController
  before_action :find_course, except: %i(index new create add_member)
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

  def member_remaining
    @users = User.not_exit_on_course @course.id
    respond_to :js
  end

  def add_member
    users_id = params[:usersChecked]
    course_id = params[:courseId]
    @course = Course.find_by id: course_id
    if @course
      begin
        UserCourse.transaction do
          users_id.each do |user_id|
            UserCourse.create!(user_id: user_id.to_i, course_id: course_id.to_i,
              status: :active, date_join: Time.now)
          end
          load_suppervisors
          load_trainees
        end
      rescue => e
        respond_to do |format|
          format.json{render json: {status: 403}}
        end
      end


      respond_to :js
    else
      respond_to do |format|
        format.json{render json: {status: 404}}
      end
    end
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
