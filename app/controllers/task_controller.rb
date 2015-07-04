class TaskController < ApplicationController
  def create
    @task = Task.new(params.require(:task).permit(:name).merge(list_id: params[:list_id], status: 0))
    if @task.save
      redirect_to list_path(params[:list_id])
    end
  end
  
  def destroy
    Task.find(params.require(:id)).destroy
    redirect_to list_path(params[:list_id])
  end
  
  def toggle
    Task.find(params[:task_id]).toggle!(:status)
    redirect_to list_path(params[:list_id])
  end
end
