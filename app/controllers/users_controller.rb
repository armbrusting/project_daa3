class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  #Paperclip was User.create
  def create
    @user = User.new( params[:user] )
    if @user.save
      flash[:success] = "Welcome to D&A Apparel!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
