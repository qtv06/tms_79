class Subject < ApplicationRecord
  has_many :tasks
  has_many :course_subjects

  mount_uploader :cover, SubjectCoverUploader

  scope :not_exit_in_course, ->(course_id) do
    where("id not in (?)", CourseSubject.subject_id_on_course(course_id))
  end
  scope :newest, ->{order created_at: :desc}
  scope :of_ids, ->(subject_ids)do
    where("id in (?)", subject_ids)
  end
  scope :hot_trend, -> do
    of_ids(UserSubject.subject_ids_have_count_large)
  end
end
