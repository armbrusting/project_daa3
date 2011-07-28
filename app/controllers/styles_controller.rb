class StylesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :only => :destroy
  
  def index
    @title = "All styles"
    @styles = Style.search(params[:search]).order.paginate(:per_page => 25, :page => params[:page])
    if params[:folder_id] != nil
    @folder = Folder.find(params[:folder_id])
    end
  end
  
  def show
    @style = Style.find(params[:id])
     if params[:folder_id] != nil
      @folder = Folder.find(params[:folder_id])
      end
    @title = @style.number
  end
  
  def new
    @style = Style.new
    @title = "New style"
  end
  
  def create
    @style = current_user.styles.build(params[:style])
    if @style.save
      flash[:success] = "Style created!"
      redirect_to(style_path(@style))
    else
      @title = "New style"
      @style.number = ""
      render 'new'
    end
  end
  
  def edit
    @style = Style.find(params[:id])
    @title = "Edit style"
  end
  
  def update
    @style = Style.find(params[:id])
    if @style.update_attributes(params[:style])
      flash[:success] = "Style information updated."
      redirect_to @style
    else
      @title = "Edit style"
      render 'edit'
    end
  end
  
  def destroy
    Style.find(params[:id]).destroy
    flash[:success] = "Style destroyed."
    redirect_to styles_path
  end
  
  def collectors
    @title = "Folders"
    @style = Style.find(params[:id])
    @folders = @style.collectors.paginate(:page => params[:page])
    render 'show_collect'
  end
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
