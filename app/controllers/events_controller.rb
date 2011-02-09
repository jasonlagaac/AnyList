class EventsController < ApplicationController
  before_filter :authenticate
  before_filter :authorised_user, :only => :destroy

  def create 
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = "Event Created!"
      redirect_to root_path
    else
      @eventlists = current_user.eventList
      render 'pages/main'
    end
  end

  def destroy
    @event.destroy
    redirect_back_or root_path
  end

  private
    def authorised_user
      @event = Event.find(params[:id])
      redirect_to root_path unless current_user?(@event.user)
    end
end