class ItemsController < ApplicationController
  before_filter :authenticate
  
  def create
    @item = Item.new(params[:item])
    
    if item_owned_by_user?(@item)
      if @item.save
        flash[:success] = "Item Created!"
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      flash[:success] = "That event doesn't exist! Please try again."
      redirect_to root_path
    end
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    if item_owned_by_user?(@item)
      Item.find_by_id(params[:id]).destroy
      redirect_back_or root_path
    else
      redirect_to root_path
    end
  end
  
  
  private 
    def item_owned_by_user?(item)
      current_user.events.find_by_id(item.event_id)
    end
end
