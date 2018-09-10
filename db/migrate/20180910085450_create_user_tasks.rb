class CreateUserTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tasks do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.string :status

      t.timestamps
    end
  end
end
