class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy

  scope :order_desc, ->{order created_at: :desc}
end
