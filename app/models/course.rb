class Course < ApplicationRecord
  has_many :user_courses
  has_many :course_subjects
end
