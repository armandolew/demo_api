class TasksController < ApplicationController

  def index
    tasks = user.tasks.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    render json: tasks.to_json, status: :ok
  end

  def show
    task = user.tasks.find_by(id: params[:id])
    render json: task.to_json, status: :ok
  end

  def create
    task = user.tasks.create(task_params)

    if task.valid?
      render json: request_response(status: 202, message: "Task created").to_json, status: :ok
    else
      render json: request_response(status: 422, message: "Unable to create task").to_json, status: :unprocessable_entity
    end
  end

  def update
    if task
      if task.update(task_update_params)
        render json: request_response(status: 202, message: "Task updated").to_json, status: :ok
      end
    else
      not_found
    end
  end

  def destroy
    if task
      task.destroy
      if task.destroyed?
        render json: request_response(status: 202, message: "Task destroyed").to_json, status: :ok
      end
    else
      not_found
    end
  end

  private

    def user
      @user ||= @current_user
    end

    def task_params
      params.require(:task).permit(:description, :website, :expiration_date)
    end

    def task_update_params
      params.require(:task).permit(:description, :website, :expiration_date, :status)
    end

    def task
      @task ||= task = user.tasks.find_by(id: params[:id])
    end

end