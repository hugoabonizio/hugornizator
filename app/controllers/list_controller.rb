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
end
