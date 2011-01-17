class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Hi, Welcome to your wish list!"
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
    def authenticate
      deny_access unless signed_in?
    end
end
