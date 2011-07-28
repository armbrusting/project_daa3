class CollectionsController < ApplicationController
  before_filter :authenticate

  def create
    @style = Style.find(params[:collection][:collected_id])
    @folder = Folder.find(params[:collection][:collector_id])
    @collection = @folder.collect!(@style)
    if @collection.save
      flash[:success] = "Style added to " + @folder.name + " | " + @folder.company.name 
      redirect_to(collection_path(@collection))
    else
      flash[:failure] = "Style was not added" 
      redirect_to(folder_styles_path(@folder_id))
    end
  end
  
  def index
    @folder = Folder.find(params[:folder_id])
    @linesheet_items = Folder.find(params[:folder_id]).linesheet.paginate(:page => params[:page])
    @title = @folder.name + " | " + @folder.company.name
  end  

  def show
    @collection = Collection.find(params[:id])
    @folder = Collection.find(params[:id]).collector
    @style = Collection.find(params[:id]).collected
    @title = "Saved style"
  end

  def edit
    @title = "Edit linesheet item"
    @collection = Collection.find(params[:id])
  end
  
  def update
    @collection = Collection.find(params[:id])
    #if 
      @collection.update_attributes(params[:collection])
     # flash[:success] = "Linesheet updated."
      #redirect_to @collection
    #else
     # @title = "Edit linesheet item"
    #  render 'edit'
    #end
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
        end
  end

  def pingmono
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'updated')
    PingMonopol.ping_mono(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end
  
  def pingdaa
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'returned')
    PingMonopol.ping_daa(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end
  
  def agreement
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'agreed')
    PingMonopol.agreed(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end
  
  def approved
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'approved')
    PingMonopol.approved(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end
  
  def shipped
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'shipped')
    PingMonopol.shipped(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end
  
  def delivered
    @collection = Collection.find(params[:id])
    @collection.update_attributes(:status => 'delivered')
    PingMonopol.delivered(@collection).deliver
    respond_to do |format|
          format.html { redirect_to @collection }
          format.js
    end
  end

  def destroy
    @style = Collection.find(params[:id]).collected
    @folder = Collection.find(params[:id]).collector
    @folder.uncollect!(@style)
    respond_to do |format|
          format.html { redirect_to @folder }
          format.js
        end
  end
end