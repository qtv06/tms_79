class CoursesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, :authenticate_suppervisor!
  before_action :find_course,
    except: %i(index new create add_member add_subject delete_member)
  before_action :find_course_to_add,
    only: %i(add_member add_subject delete_member)
  before_action :load_subjects, :load_trainees, :load_suppervisors, only: :show
  before_action :load_subject_ids, :load_user_ids, only: :start

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
    begin
      AddMemberService.new.call users_id, @course
      load_suppervisors
      load_trainees
    rescue
      respond_to do |format|
        format.json{render json: {status: 403}}
      end
    end

    respond_to :js
  end

  def subject_remaining
    @subjects = Subject.not_exit_in_course @course.id
    respond_to :js
  end

  def add_subject
    subjects_id = params[:subjectsId]
    begin
      CourseSubject.transaction do
        subjects_id.each do |subject_id|
          CourseSubject.create!(course_id: @course.id,
            subject_id: subject_id.to_i)
        end
      end

      load_subjects
    rescue
      respond_to do |format|
        format.json{render json: {status: 403}}
      end
    end

    respond_to :js
  end

  def delete_member
    @user_id = params[:user_id]
    @user_course = UserCourse.find_by user_id: @user_id, course_id: @course.id
    if @user_course&.destroy
      user = User.find_by id: @user_id
      if user
        UserNotifierMailer.send_mail_after_remove_trainee(user,
          @course).deliver_later
      end
      respond_to :js
    else
      respond_to do |format|
        format.json{render json: {status: 404}}
      end
    end
  end

  def delete_subject
    @subject_id = params[:subject_id]
    @course_subject = CourseSubject.find_by course_id: @course.id,
      subject_id: @subject_id
    if @course_subject&.destroy
      respond_to :js
    else
      flash[:danger] = t "flash.course.delete_fail"
      redirect_to course_path(@course)
    end
  end

  def start
    start_course_service = StartCourseService.new @course, @user_ids, @subject_ids
    start_course_service.call
    if start_course_service.success?
      flash[:success] = I18n.t("flash.course.start", course_name: course.name)
    else
      flash[:danger] = I18n.t("flash.fail")
    end

    redirect_to courses_path
  end

  private

  def load_subject_ids
    @subject_ids = @course.subject_ids
  end

  def load_user_ids
    @user_ids = @course.user_ids
  end

  def course_params
    params.require(:course).permit :name, :description, :time_training, :cover
  end

  def find_course
    @course = Course.find_by id: params[:id]
    return @course if @course
    flash[:danger] = t "flash.not_found"
    redirect_to courses_path
  end

  def find_course_to_add
    @course = Course.find_by id: params[:courseId]
    return if @course
    respond_to do |format|
      format.json{render json: {status: 404}}
    end
  end
end
