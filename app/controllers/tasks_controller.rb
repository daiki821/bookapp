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

  def edit 
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end

  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy!
    redirect_to root_path, notice: '削除しました'
  end


  private
  def task_params
    params.require(:task).permit(
      :image,
      :title,
      :completed_at,
      :completed,
    )
  end
end