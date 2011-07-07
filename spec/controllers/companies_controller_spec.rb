require 'spec_helper'

describe CompaniesController do
  render_views
  
  describe "access control" do
    
      it "should deny access to 'index'" do
        get :index 
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'show'" do
        get :show, :id => 1
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'new'" do
        get :new
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'create'" do
        post :create
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'edit'" do
        get :edit, :id => 1
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => 1
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'destroy'" do
        delete :destroy, :id => 1
        response.should redirect_to(signin_path)
      end
  end
  
  describe "GET 'index'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @company = Factory(:company, :user => @user)
      second = Factory(:company, :name => "Bob", :user => @user)
      third  = Factory(:company, :name => "Ben", :user => @user)
      @companies = [@company, second, third]
      30.times do
        @companies << Factory(:company, :name => Factory.next(:name),
                              :user => @user)
      end
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All companies")
    end

    it "should have an element for each company" do
      get :index
      @companies[0..2].each do |company|
        response.should have_selector("li", :content => company.name)
      end
    end
    
    it "should paginate companies" do
      get :index
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/companies?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/companies?page=2",
                                         :content => "Next")
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @company = Factory(:company, :user => @user)
    end

    it "should be successful" do
      get :show, :id => @company
      response.should be_success
    end

    it "should find the right company" do
      get :show, :id => @company
      assigns(:company).should == @company
    end

    it "should have the right title" do
      get :show, :id => @company
      response.should have_selector("title", :content => @company.name)
    end

    it "should include the company's name" do
        get :show, :id => @company
        response.should have_selector("h1", :content => @company.name)
    end

  end  

  describe "GET 'new'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='company[name]']
                                  [type='text']")
    end
                                   
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New company")
      end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

      describe "failure" do

        before(:each) do
          @attr = { :name => "" }
        end

        it "should not create a company" do
          lambda do
            post :create, :company => @attr
          end.should_not change(Company, :count)
        end

        it "should have the right title" do
          post :create, :company => @attr
          response.should have_selector("title", :content => "New company")
        end

        it "should render the 'new' page" do
          post :create, :company => @attr
          response.should render_template('new')
        end
      end
      
    describe "success" do

      before(:each) do
        @attr = { :name => "Lorem ipsum" }
      end

      it "should create a company" do
        lambda do
          post :create, :company => @attr
        end.should change(Company, :count).by(1)
      end

      it "should redirect to the company show page" do
        post :create, :company => @attr
        response.should redirect_to(company_path(assigns(:company)))
      end

      it "should have a flash message" do
        post :create, :company => @attr
        flash[:success].should =~ /company created/i
      end
    end      
  end 
  describe "GET 'edit'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @company = Factory(:company, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @company
      response.should be_success
    end

    it "should have the right name" do
      get :edit, :id => @company
      response.should have_selector("title", :content => "Edit company")
    end
  end 
  
  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @company = Factory(:company, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @company, :company=> @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @company, :company => @attr
        response.should have_selector("title", :content => "Edit company")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Company" }
      end

      it "should change the company's attributes" do
        put :update, :id => @company, :company => @attr
        @company.reload
        @company.name.should  == @attr[:name]
      end

      it "should redirect to the company show page" do
        put :update, :id => @company, :company => @attr
        response.should redirect_to(company_path(@company))
      end

      it "should have a flash message" do
        put :update, :id => @company, :company => @attr
        flash[:success].should =~ /updated/
      end
    end 
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @company = Factory(:company, :user => @user)
    end
    
    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @company
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @company
        end.should change(Company, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @company
        response.should redirect_to(companies_path)
      end
    end
  end
end
