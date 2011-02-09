class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
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
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
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
  
end
