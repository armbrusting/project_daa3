class NoticesController < ApplicationController
  before_filter :authenticate
  
  def create
    #@folder = Folder.find(params[:folder_id])
    @notice = Notice.create(params[:notice])
    @notice.save
    respond_to do |format|
      format.html
      format.js
      end
  end

  
  def update
  end
  
  def destroy
    @notice = Notice.find(params[:folder_id])
    @notice.destroy
    respond_to do |format|
      format.html { redirect_to @folder }
      format.js
    end
  end
end