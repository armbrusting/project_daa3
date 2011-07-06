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
      sign_in @user
      flash[:success] = "Welcome to D&A Apparel!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end
  end
end
