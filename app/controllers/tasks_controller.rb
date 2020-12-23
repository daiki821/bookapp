class TasksController < ApplicationController
  before_action :authenticate_user!

  # まだ未完了のタスク一覧
  def todo
    todo = current_user.tasks.where(completed: 'false')
    @todo = todo.page(params[:page]).per(6)
  end
  # 完了したタスク一覧
  def done
    done = current_user.tasks.where(completed: 'true')
    @done = done.page(params[:page]).per(6)
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to todo_tasks_path, notice: '保存できました'
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
      redirect_to todo_tasks_path, notice: '更新できました'
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