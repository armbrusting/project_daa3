require 'spec_helper'

describe "Folders" do
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new folder" do
        lambda do 
          user = Factory(:user)
          visit signin_path
          # The test automatically follows the redirect to the signin page.
          fill_in :email,    :with => user.email
          fill_in :password, :with => user.password
          click_button
          # The test follows the redirect again, this time to company/new.
          visit newfolder_path
          fill_in "Name",         :with => ""
          click_button
          response.should render_template('folders/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Folder, :count)
      end
      
      describe "success" do

        it "should make a new folder" do
          lambda do
            user = Factory(:user)
            visit signin_path
            fill_in :email,    :with => user.email
            fill_in :password, :with => user.password
            click_button
            visit newfolder_path
            fill_in "Name",         :with => "ChumbaWumba"
            click_button
            response.should have_selector("div.flash.success",
                                          :content => "Folder created!")
            response.should render_template('folders/show')
          end.should change(Folder, :count).by(1)
        end
      end
    end      
  end
end
