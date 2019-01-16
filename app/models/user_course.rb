class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  delegate :name, :cover, to: :course, prefix: true

  enum status: {open: 0, active: 1, close: 2}

  scope :user_on_course_with_a_role, ->(course_id, role) do
    UserCourse.user_on_course(course_id).merge(role)
  end

  scope :user_on_course, ->(course_id) do
    joins(:user, :course)
      .select("users.*, user_courses.status")
      .where(course_id: course_id)
  end

  scope :user_id_on_course, ->(course_id) do
    joins(:user)
      .select("users.id")
      .where(course_id: course_id)
  end

  def self.new_user_course user_id, course_id
    UserCourse.new(user_id: user_id.to_i,
      course_id: course_id, status: :open, date_join: Time.now)
  end
end
