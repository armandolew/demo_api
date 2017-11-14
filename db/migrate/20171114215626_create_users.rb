class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :auth_token
  end
end
