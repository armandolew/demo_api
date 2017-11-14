class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :description
      t.string :website
      t.boolean :status, default: false
      t.datetime :expiration_date

      t.timestamps
    end
    add_index :tasks, :description
    add_index :tasks, :website
  end
end
