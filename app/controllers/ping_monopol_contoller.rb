class CollectionsController < ApplicationController
  
  def create
    UserMailer.ping.deliver
    flash[:notice] = 'ping sent!'
   # redirect_to root_path # or wherever
  end
  
end