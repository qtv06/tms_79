class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  scope :get_subjects, ->(course_id) do
    joins(:course, :subject)
      .select("subjects.*").where(course_id: course_id)
  end
end
