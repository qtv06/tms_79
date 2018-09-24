class CreateUserSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subjects do |t|
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
