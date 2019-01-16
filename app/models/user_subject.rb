class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  delegate :cover, :name, :duration, :description, :content, :id,
    to: :subject, prefix: true

  enum status: {open: 0, inprogess: 1, finish: 2}

  scope :of_user_in_course, ->(user_id, course_id) do
    where(user_id: user_id, course_id: course_id)
  end

  scope :subject_ids_have_count_large, -> do
    select("user_subjects.subject_id")
      .having("count(user_subjects.id) > ?", 15)
      .group(:subject_id).pluck(:subject_id)
  end

  def update_status_to_finish
    update_attribute :status, :finish
  end
end
