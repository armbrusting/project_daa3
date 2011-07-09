# == Schema Information
#
# Table name: collections
#
#  id           :integer         not null, primary key
#  collector_id :integer
#  collected_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Collection do

  before(:each) do
    @user = Factory(:user)
    @collector = Factory(:folder, :user => @user, :name => "foobar")
    @collected = Factory(:style, :user => @user, :number => "DA-123456")

    @collection = @collector.collections.build(:collected_id => @collected.id)
  end

  it "should create a new instance given valid attributes" do
    @collection.save!
  end
  
  describe "collect methods" do

    before(:each) do
      @collection.save
    end

    it "should have a collector attribute" do
      @collection.should respond_to(:collector)
    end

    it "should have the right collector folder" do
      @collection.collector.should == @collector
    end

    it "should have a collected attribute" do
      @collection.should respond_to(:collected)
    end

    it "should have the right collected style" do
      @collection.collected.should == @collected
    end
  end

  describe "validations" do

    it "should require a collector_id" do
      @collection.collector_id = nil
      @collection.should_not be_valid
    end

    it "should require a collected_id" do
      @collection.collected_id = nil
      @collection.should_not be_valid
    end
  end
end
