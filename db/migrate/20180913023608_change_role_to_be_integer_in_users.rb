class ChangeRoleToBeIntegerInUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :role, :integer, default: 1, null: false
  end

  def down
    change_column :users, :role, :string
  end
end
