class CreateCourseSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :course_subjects do |t|
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true
      t.string :status
      t.datetime :finished_at

      t.timestamps
    end
  end
end
