class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum status: {active: 0, close: 1}

  scope :user_on_course_with_a_role, ->(course_id, role) do
    UserCourse.user_on_course(course_id).merge(role)
  end

  scope :user_on_course, ->(course_id) do
    joins(:user, :course)
      .select("users.*, user_courses.status")
      .where(course_id: course_id)
  end

  scope :user_id_on_course, ->(course_id) do
    joins(:user, :course)
      .select("users.id")
      .where(course_id: course_id)
  end
end
