class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :profileImg
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password
      t.boolean :isActive
      t.boolean :isAdmin
      t.timestamps
    end
  end
end
