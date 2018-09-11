class User < ApplicationRecord
  has_many :user_courses
  has_many :user_tasks
end
