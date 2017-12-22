class AddConfirmationTokenToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :confirmation_token, :string
  	add_column :users, :active, :boolean, default: false
  end
end
