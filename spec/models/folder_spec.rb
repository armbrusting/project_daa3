# == Schema Information
#
# Table name: folders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Folder do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "folder name" }
  end
  
  it "should create a new foler instance" do
     @user.folders.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @folder = @user.folders.create(@attr)
    end

    it "should have a user attribute" do
       @folder.should respond_to(:user)
    end

    it "should have the right associated user" do
       @folder.user_id.should == @user.id
       @folder.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Folder.new(@attr).should_not be_valid
    end

    it "should require a nonblank name" do
      @user.folders.build(:name => "  ").should_not be_valid
    end

    it "should reject a long name" do
      @user.folders.build(:name => "a" * 141).should_not be_valid
    end
    
    it "should reject duplicate names" do
      @user.folders.create!(@attr)
      folder_with_duplicate_name = @user.folders.new(@attr)
      folder_with_duplicate_name.should_not be_valid
    end
    
    it "should reject a name identical up to case" do
      upcased_name = @attr[:name].upcase
      @user.folders.create!(@attr.merge(:name => upcased_name))
      folder_with_duplicate_name = @user.folders.new(@attr)
      folder_with_duplicate_name.should_not be_valid
    end
  end

  describe "collections" do

    before(:each) do
      @folder = @user.folders.create!(@attr)
      @collected = Factory(:style, :user => @user, :number => "DA-123456")
    end

    it "should have a collections method" do
      @folder.should respond_to(:collections)
    end
  
    it "should have a collecting method" do
      @folder.should respond_to(:collecting)
    end
    
    it "should have a collect! method" do
      @folder.should respond_to(:collect!)
    end

    it "should collect a style" do
      @folder.collect!(@collected)
      @folder.should be_collecting(@collected)
    end

    it "should include the collected style in the collecting array" do
      @folder.collect!(@collected)
      @folder.collecting.should include(@collected)
    end
 
    it "should have an uncollect! method" do
      @folder.should respond_to(:uncollect!)
    end

    it "should uncollect a style" do
      @folder.collect!(@collected)
      @folder.uncollect!(@collected)
      @folder.should_not be_collecting(@collected)
    end  
  end
end
