class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @title = "Sign up"
  end

  #Paperclip change
  def create
    @user = User.create( params[:user] )
  end
  #end Paperclip change
  
end
