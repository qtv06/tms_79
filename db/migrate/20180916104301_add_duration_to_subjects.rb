class AddDurationToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :duration, :integer
  end
end
