class StylesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :only => :destroy
  
  def index
    @title = "All styles"
    @styles = Style.paginate(:page => params[:page])
  end
  
  def show
    @style = Style.find(params[:id])
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
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
