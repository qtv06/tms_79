class Subject < ApplicationRecord
  ATTRIBUTES = [:name, :description, :content, :cover, :duration,
    tasks_attributes: [:id, :name, :description, :_destroy]]
  has_many :tasks
  has_many :course_subjects
  accepts_nested_attributes_for :tasks, reject_if: :reject_task, allow_destroy: true

  mount_uploader :cover, SubjectCoverUploader

  scope :not_exit_in_course, ->(course_id) do
    where("id not in (?)", CourseSubject.subject_id_on_course(course_id))
  end
  scope :newest, ->{order created_at: :desc}

  def reject_task(attributes)
    attributes['name'].blank?
  end
end
