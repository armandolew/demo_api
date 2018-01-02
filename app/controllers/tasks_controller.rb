class TasksController < ApplicationController
  before_action :can_perform_action?
  before_action :try_to_inject_assigner_relationship, on: :create

  def move
    case params[:option]
      when 'up' then task.move_up
      when 'down' then task.move_down
      when 'place' then task.place_at(params[:position].to_i) if params[:position].present?
    end
    render json: render_element_json(task, TaskResource)
  end

  private

    def task_params
      params.require(:task).permit(:description, :website, task_labels_attributes: [:label_id, :_id])
    end

    def try_to_inject_assigner_relationship
      old_parameters = params.dup
      params[:data][:relationships] = {
        'user' => {
          'data' => {
            'type' => 'users',
            'id' => current_user.id.to_s
          }
        }
      }
    rescue
      self.params = old_parameters
    end
end
