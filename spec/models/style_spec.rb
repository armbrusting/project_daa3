# == Schema Information
#
# Table name: styles
#
#  id                 :integer         not null, primary key
#  number             :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  description        :string(255)
#  department         :string(255)
#  classification     :string(255)
#  season             :string(255)
#  printed            :boolean
#  embellished        :boolean
#  moq                :integer
#

require 'spec_helper'

describe Style do

  before(:each) do
    @user = Factory(:user)
    @attr = { :number => "DA-123456" }
  end

  it "should create a new instance given valid attributes" do
    @user.styles.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @style = @user.styles.create(@attr)
    end

    it "should have a user attribute" do
      @style.should respond_to(:user)
    end

    it "should have the right associated user" do
      @style.user_id.should == @user.id
      @style.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Style.new(@attr).should_not be_valid
    end

    it "should accept valid numbers" do
      articles = %w[da-123456 DA-234567 Da-345678]
      articles.each do |article|
        valid_number_style = @user.styles.create!(:number => article)
        valid_number_style.should be_valid
      end
    end

    it "should reject invalid numbers" do
      numbers = %w[da0000000 d-a000000 da0-000000]
      numbers.each do |n|
        invalid_number = @user.styles.new(:number => n)
        invalid_number.should_not be_valid
      end
    end

    it "should reject duplicate numbers" do
      @user.styles.create!(@attr)
      style_with_duplicate_number = @user.styles.new(@attr)
      style_with_duplicate_number.should_not be_valid
    end

    it "should reject a number identical up to case" do
      upcased_number = @attr[:number].upcase
      @user.styles.create!(@attr.merge(:number => upcased_number))
      style_with_duplicate_number = @user.styles.new(@attr)
      style_with_duplicate_number.should_not be_valid
    end
  end
  describe "collections" do

    before(:each) do
      @style = @user.styles.create!(@attr)
      @collector = Factory(:folder, :user => @user, :name => "foobar")
    end
    
    it "should have a collections method" do
      @style.should respond_to(:collections)
    end

    it "should have a collectors method" do
      @style.should respond_to(:collectors)
    end

    it "should include the collector in the collectors array" do
      @collector.collect!(@style)
      @style.collectors.should include(@collector)
    end
  end
end
