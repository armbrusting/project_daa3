require 'spec_helper'

describe StylesController do
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
      @style = Factory(:style, :user => @user)
      second = Factory(:style, :number => "DA-000004", :user => @user)
      third  = Factory(:style, :number => "DA-000005", :user => @user)
      @styles = [@style, second, third]
      30.times do
        @styles << Factory(:style, :number => Factory.next(:stynumber),
                              :user => @user)
      end
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All styles")
    end

    it "should have an element for each style" do
      get :index
      @styles[0..2].each do |style|
        response.should have_selector("li", :content => style.number)
      end
    end
    
    it "should paginate styles" do
      get :index
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/styles?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/styles?page=2",
                                         :content => "Next")
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @style = Factory(:style, :user => @user)
    end

    it "should be successful" do
      get :show, :id => @style
      response.should be_success
    end

    it "should find the right style" do
      get :show, :id => @style
      assigns(:style).should == @style
    end

    it "should have the right title" do
      get :show, :id => @style
      response.should have_selector("title", :content => @style.number)
    end

    it "should include the style's number" do
        get :show, :id => @style
        response.should have_selector("h1", :content => @style.number)
    end

  end  

  describe "GET 'new'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    it "should have a number field" do
      get :new
      response.should have_selector("input[name='style[number]']
                                  [type='text']")
    end
                                   
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New style")
      end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

      describe "failure" do

        before(:each) do
          @attr = { :number => "" }
        end

        it "should not create a style" do
          lambda do
            post :create, :style => @attr
          end.should_not change(Style, :count)
        end

        it "should have the right title" do
          post :create, :style => @attr
          response.should have_selector("title", :content => "New style")
        end

        it "should render the 'new' page" do
          post :create, :style => @attr
          response.should render_template('new')
        end
      end
      
    describe "success" do

      before(:each) do
        @attr = { :number => "DA-099999" }
      end

      it "should create a style" do
        lambda do
          post :create, :style => @attr
        end.should change(Style, :count).by(1)
      end

      it "should redirect to the style show page" do
        post :create, :style => @attr
        response.should redirect_to(style_path(assigns(:style)))
      end

      it "should have a flash message" do
        post :create, :style => @attr
        flash[:success].should =~ /style created/i
      end
    end      
  end 
  describe "GET 'edit'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @style = Factory(:style, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @style
      response.should be_success
    end

    it "should have the right number" do
      get :edit, :id => @style
      response.should have_selector("title", :content => "Edit style")
    end
  end 
  
  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @style = Factory(:style, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :number => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @style, :style=> @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @style, :style => @attr
        response.should have_selector("title", :content => "Edit style")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :number => "DA-009999" }
      end

      it "should change the style's attributes" do
        put :update, :id => @style, :style => @attr
        @style.reload
        @style.number.should  == @attr[:number]
      end

      it "should redirect to the style show page" do
        put :update, :id => @style, :style => @attr
        response.should redirect_to(style_path(@style))
      end

      it "should have a flash message" do
        put :update, :id => @style, :style => @attr
        flash[:success].should =~ /updated/
      end
    end 
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @style = Factory(:style, :user => @user)
    end
    
    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @style
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
          delete :destroy, :id => @style
        end.should change(Style, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @style
        response.should redirect_to(styles_path)
      end
    end
  end
end
