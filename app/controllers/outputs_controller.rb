class OutputsController < ApplicationController
  before_action :authenticate_user!
  def show
    task = Task.find(params[:task_id])
    if task.output
      @output = task.output
    else
      redirect_to edit_task_outputs_path(task_id: task.id)
    end

    
  end

  def edit
    @task = Task.find(params[:task_id])
    @output = @task.prepare_output(current_user)
  end

  def update
    @task = Task.find(params[:task_id])
    @output = @task.prepare_output(current_user)
    
    if @output.update(output_params)
      redirect_to task_outputs_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end

  private

  def output_params
    params.require(:output).permit(:content)
  end
end