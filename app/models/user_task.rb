class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user
  delegate :name, :description, to: :task, prefix: true

  enum status: {open: 0, doing: 1, finish: 2}

  scope :of_user_in_subject, ->(user_id, task_ids) do
    where("task_id in (?) and user_id = ?",
      task_ids, user_id)
  end

  def update_status_to_doing
    update_attribute :status, :doing
  end

  def update_started_time
    update_attribute :started_at, Time.now
  end

  def update_status_to_finish
    update_attribute :status, :finish
  end

  def update_finished_time
    update_attribute :finished_at, Time.now
  end

  def update_time_status_to_start_user_task
    update_status_to_doing
    update_started_time
  end

  def update_time_status_to_finish_user_task
    update_status_to_finish
    update_finished_time
  end
end
