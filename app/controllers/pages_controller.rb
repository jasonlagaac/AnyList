class PagesController < ApplicationController
  def main
    if signed_in?
      # variables are for the events listings and the
      # creation of new events from the main page
      @eventlists = current_user.events.all()
      @event = Event.new()
      
      # variable for page title
      @title = current_user.username + "'s WishList"
    else
      @title = "Welcome to WishList"
    end
  end
  
  def about
  end
end
