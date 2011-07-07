class CompaniesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :only => :destroy
  
  def index
    @title = "All companies"
    @companies = Company.paginate(:page => params[:page])
  end
  
  def show
    @company = Company.find(params[:id])
    @title = @company.name
  end
  
  def new
    @company = Company.new
    @title = "New company"
  end
  
  def create
    @company = current_user.companies.build(params[:company])
    if @company.save
      flash[:success] = "Company created!"
      redirect_to(company_path(@company))
    else
      @title = "New company"
      @company.name = ""
      render 'new'
    end
  end
  
  def edit
    @company = Company.find(params[:id])
    @title = "Edit company"
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:success] = "Company information updated."
      redirect_to @company
    else
      @title = "Edit company"
      render 'edit'
    end
  end
  
  def destroy
    Company.find(params[:id]).destroy
    flash[:success] = "Company destroyed."
    redirect_to companies_path
  end
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
