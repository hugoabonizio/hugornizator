class ListController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @lists = current_user.lists
  end
  
  def create
    @list = List.new(params.require(:list).permit(:name).merge(user_id: current_user.id))
    if @list.save
      redirect_to root_path
    end
  end
  
  def show
    @list = List.find(params.require(:id))
    @tasks = @list.tasks
    @left = @tasks.select { |task| !task.status? }.size
  end
  
  def destroy
    List.where(user_id: current_user.id, id: params.require(:id)).destroy_all
    redirect_to root_path
  end
end
