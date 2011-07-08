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
end
