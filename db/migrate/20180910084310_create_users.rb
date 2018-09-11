class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :phone_number
      t.string :avatar
      t.string :role

      t.timestamps
    end
  end
end
