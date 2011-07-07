require 'spec_helper'

describe Company do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "company name"  }
  end
  
  it "should create a new company instance" do
    @user.companies.create!(@attr)
  end
  
  describe "user associations" do
    before(:each) do
      @company = @user.companies.create(@attr)
    end

    it "should have a user attribute" do
      @company.should respond_to(:user)
    end

    it "should have the right associated user" do
      @company.user_id.should == @user.id
      @company.user.should == @user
    end
  end
 
  describe "validations" do

      it "should require a user id" do
        Company.new(@attr).should_not be_valid
      end

      it "should require a nonblank name" do
        @user.companies.build(:name => "  ").should_not be_valid
      end

      it "should reject a long name" do
        @user.companies.build(:name => "a" * 141).should_not be_valid
      end
      
      it "should reject duplicate names" do
        @user.companies.create!(@attr)
        company_with_duplicate_name = @user.companies.new(@attr)
        company_with_duplicate_name.should_not be_valid
      end
      
      it "should reject a name identical up to case" do
        upcased_name = @attr[:name].upcase
        @user.companies.create!(@attr.merge(:name => upcased_name))
        company_with_duplicate_name = @user.companies.new(@attr)
        company_with_duplicate_name.should_not be_valid
      end
  end

end