class CollectionsController < ApplicationController
  before_filter :authenticate

  def create
    @style = Style.find(params[:collection][:collected_id])
    @folder = Folder.find(params[:collection][:collector_id])
    @folder.collect!(@style)
    redirect_to @style
  end

  def destroy
    @style = Collection.find(params[:id]).collected
    @folder = Collection.find(params[:id]).collector
    @folder.uncollect!(@style)
    redirect_to @style
  end
end