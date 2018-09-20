class ChangeStatusToIntegerUserTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :user_tasks, :status, :integer, default: 0, null: false
  end
end
