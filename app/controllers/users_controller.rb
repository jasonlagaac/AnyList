class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :update_password]
  before_filter :correct_user, :only => [:edit, :update, :update_password]
  
  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def show
    @user = User.find(params[:id])
    @eventlists = @user.eventList
    @event = Event.new if signed_in?
    @title = @user.username
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to Wishlist"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
  end
  
  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Password Successfully Changed"
      redirect_to @user
    else
      @title = "Edit User"
      render :edit
    end 
  end
  
  def update_details
    @user = User.find(params[:id])

    if bio_and_location_update 
      flash[:success] = "Details Successfully Updated"
      redirect_to @user
    else
      @title = "Edit User"
      render :edit
    end 
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  private
  
    def bio_and_location_update
      @user.update_attribute(:bio, params[:user][:bio]) && @user.update_attribute(:location, params[:user][:location])
    end  
end
