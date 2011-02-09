class PagesController < ApplicationController
  def main
    if signed_in?
      @event = Event.new
      @eventlists = current_user.eventList
    end
  end
  
  def about
  end
end
