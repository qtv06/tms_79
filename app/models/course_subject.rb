class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  scope :subjects_on_course, ->(course_id) do
    joins(:course, :subject)
      .select("subjects.*").where(course_id: course_id)
  end
end
