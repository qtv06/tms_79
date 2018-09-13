class AddCoverToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :cover, :string
  end
end
