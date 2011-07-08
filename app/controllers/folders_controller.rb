class FoldersController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :only => :destroy
  
  def index
    @title = "All folders"
    @folders = Folder.paginate(:page => params[:page])
  end
  
  def show
    @folder = Folder.find(params[:id])
    @title = @folder.name
  end
  
  def new
    @folder = Folder.new
    @title = "New folder"
  end
  
  def create
    @folder = current_user.folders.build(params[:folder])
    if @folder.save
      flash[:success] = "Folder created!"
      redirect_to(folder_path(@folder))
    else
      @title = "New folder"
      @folder.name = ""
      render 'new'
    end
  end
  
  def edit
    @folder = Folder.find(params[:id])
    @title = "Edit folder"
  end
  
  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(params[:folder])
      flash[:success] = "Folder information updated."
      redirect_to @folder
    else
      @title = "Edit folder"
      render 'edit'
    end
  end
  
  def destroy
    Folder.find(params[:id]).destroy
    flash[:success] = "Folder destroyed."
    redirect_to folders_path
  end
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
