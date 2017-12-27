class TasksController < ApplicationController
  before_action :can_perform_action?

  def create
    begin
      task = current_user.tasks.create(task_params)
      render json: render_element_json(task, TaskResource)
    rescue => e
      handle_exceptions(e)
    end
  end

  def update
    begin
      task.update_attributes(task_params)
      render json: render_element_json(task, TaskResource)
    rescue => e
      handle_exceptions(e)
    end
  end

  def search
  	tasks = current_user.tasks.tagged_with("#{params[:tags]}", wild: true, :any=> true)
  	tasks_resources = tasks.map{ |task| TaskResource.new(task, self) }
  	render json: JSONAPI::ResourceSerializer.new(TaskResource).serialize_to_hash(tasks_resources)
  end

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
      params.require(:data).require(:attributes).permit(:description, :status, :tag_list, :website, :image)
    end

    def task
      @task ||= current_user.tasks.find_by(id: params[:id])
    end
end