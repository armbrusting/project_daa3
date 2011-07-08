require 'spec_helper'

describe FoldersController do
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
      @folder = Factory(:folder, :user => @user)
      second = Factory(:folder, :name => "Bob", :user => @user)
      third  = Factory(:folder, :name => "Ben", :user => @user)
      @folders = [@folder, second, third]
      30.times do
        @folders << Factory(:folder, :name => Factory.next(:foldname),
                              :user => @user)
      end
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All folders")
    end

    it "should have an element for each folder" do
      get :index
      @folders[0..2].each do |folder|
        response.should have_selector("li", :content => folder.name)
      end
    end
    
    it "should paginate folders" do
      get :index
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/folders?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/folders?page=2",
                                         :content => "Next")
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @folder = Factory(:folder, :user => @user)
    end

    it "should be successful" do
      get :show, :id => @folder
      response.should be_success
    end

    it "should find the right folder" do
      get :show, :id => @folder
      assigns(:folder).should == @folder
    end

    it "should have the right title" do
      get :show, :id => @folder
      response.should have_selector("title", :content => @folder.name)
    end

    it "should include the folder's name" do
        get :show, :id => @folder
        response.should have_selector("h1", :content => @folder.name)
    end

  end  

  describe "GET 'new'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='folder[name]']
                                  [type='text']")
    end
                                   
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New folder")
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

        it "should not create a folder" do
          lambda do
            post :create, :folder => @attr
          end.should_not change(Company, :count)
        end

        it "should have the right title" do
          post :create, :folder => @attr
          response.should have_selector("title", :content => "New folder")
        end

        it "should render the 'new' page" do
          post :create, :folder => @attr
          response.should render_template('new')
        end
      end
      
    describe "success" do

      before(:each) do
        @attr = { :name => "Lorem ipsum" }
      end

      it "should create a folder" do
        lambda do
          post :create, :folder => @attr
        end.should change(Folder, :count).by(1)
      end

      it "should redirect to the folder show page" do
        post :create, :folder => @attr
        response.should redirect_to(folder_path(assigns(:folder)))
      end

      it "should have a flash message" do
        post :create, :folder => @attr
        flash[:success].should =~ /folder created/i
      end
    end      
  end 
  describe "GET 'edit'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @folder = Factory(:folder, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @folder
      response.should be_success
    end

    it "should have the right name" do
      get :edit, :id => @folder
      response.should have_selector("title", :content => "Edit folder")
    end
  end 
  
  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @folder = Factory(:folder, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @folder, :folder=> @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @folder, :folder => @attr
        response.should have_selector("title", :content => "Edit folder")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Company" }
      end

      it "should change the folder's attributes" do
        put :update, :id => @folder, :folder => @attr
        @folder.reload
        @folder.name.should  == @attr[:name]
      end

      it "should redirect to the folder show page" do
        put :update, :id => @folder, :folder => @attr
        response.should redirect_to(folder_path(@folder))
      end

      it "should have a flash message" do
        put :update, :id => @folder, :folder => @attr
        flash[:success].should =~ /updated/
      end
    end 
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @folder = Factory(:folder, :user => @user)
    end
    
    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @folder
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
          delete :destroy, :id => @folder
        end.should change(Folder, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @folder
        response.should redirect_to(folders_path)
      end
    end
  end
end
