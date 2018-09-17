class Subject < ApplicationRecord
  has_many :tasks
  has_many :course_subjects

  mount_uploader :cover, SubjectCoverUploader

  scope :not_exit_in_course, ->(course_id) do
    where("id not in (?)", CourseSubject.subject_id_on_course(course_id))
  end
  scope :newest, ->{order created_at: :desc}
end
