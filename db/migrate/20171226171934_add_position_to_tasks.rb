class AddPositionToTasks < ActiveRecord::Migration[5.1]
  def change
  	add_column :tasks, :task_position, :integer
  	add_index :tasks, :task_position
  end
end
