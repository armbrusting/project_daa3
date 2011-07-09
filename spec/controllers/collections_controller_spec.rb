require 'spec_helper'

describe CollectionsController do

  describe "access control" do

    it "should require signin for create" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should require signin for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @collector = Factory(:folder, :user => @user, :name => "foobar")
      @collected = Factory(:style, :user => @user, :number => "DA-123456")
    end

    it "should create a collection" do
      lambda do
        post :create, :collection => { :collector_id => @collector, 
                                        :collected_id => @collected }
        response.should be_redirect
      end.should change(Collection, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @collector = Factory(:folder, :user => @user, :name => "foobar")
      @collected = Factory(:style, :user => @user, :number => "DA-123456")
      @collector.collect!(@collected)
      @collection = @collector.collections.find_by_collected_id(@collected)
    end

    it "should destroy a collection" do
      lambda do
        delete :destroy, :id => @collection
        response.should be_redirect
      end.should change(Collection, :count).by(-1)
    end
  end
end