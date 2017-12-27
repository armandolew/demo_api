class AddIndexToTaskPosition < ActiveRecord::Migration[5.1]
  def change
  	add_index :tasks, [:task_position, :user_id], unique: true
  end
end
