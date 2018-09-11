class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
end
