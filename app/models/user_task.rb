class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user
  delegate :name, :description, to: :task, prefix: true

  enum status: {open: 0, doing: 1, finish: 2}

  scope :of_user_in_subject, ->(user_id, task_ids) do
    where("task_id in (?) and user_id = ?",
      task_ids, user_id)
  end
end
