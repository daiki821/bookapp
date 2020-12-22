class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = current_user.tasks.all
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end


  private
  def task_params
    params.require(:task).permit(
      :image,
      :title,
      :completed_at,
    )
  end
end