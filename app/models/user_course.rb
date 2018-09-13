class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :user_on_course_with_a_role, ->(course_id, role) do
    joins(:user, :course)
      .select("users.*, user_courses.status")
      .where("course_id = ?", course_id).merge(role)
  end
end
