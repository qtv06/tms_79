class AddCourseIdToUserSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :user_subjects, :course_id, :integer
  end
end
