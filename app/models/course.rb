class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  mount_uploader :cover, CourseCoverUploader

  scope :order_desc, ->{order created_at: :desc}
end
