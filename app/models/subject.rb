class Subject < ApplicationRecord
  has_many :tasks
  has_many :course_subjects

  scope :not_exit_in_course, ->(course_id) do
    where("id not in (?)", CourseSubject.subject_id_on_course(course_id))
  end
end
