class StartCourseService
  attr_accessor :course, :user_ids, :subject_ids, :errors

  def initialize course, user_ids, subject_ids
    @course = course
    @user_ids = user_ids
    @subject_ids = subject_ids
    @errors = []
  end

  def call
    start_course
  end

  def success?
    binding.pry
    errors.nil?
  end

  private

  def start_course
    user_subjects = []
    user_tasks = []
    ActiveRecord::Base.transaction do
      course.user_courses.update_all(status: :active)
      subject_ids.each do |subject_id|
        task_ids = Task.ids_of_subject(subject_id).pluck(:id)
        user_ids.each do |user_id|
          user_subjects << UserSubject.new(user_id: user_id,
            subject_id: subject_id, course_id: course.id)
          task_ids.each do |task_id|
            user_tasks << UserTask.new(task_id: task_id, user_id: user_id,
              started_at: Time.now)
          end
        end
      end
      UserSubject.import user_subjects, validate: true
      UserTask.import user_tasks, validate: true
    end
  rescue Exception => e
    errors << e
  end
end
