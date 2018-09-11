class Subject < ApplicationRecord
  has_many :tasks
  has_many :course_subjects
end
